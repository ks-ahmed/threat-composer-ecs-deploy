
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  public_azs  = slice(data.aws_availability_zones.available.names, 0, length(var.public_subnet_suffixes))
  private_azs = slice(data.aws_availability_zones.available.names, 0, length(var.private_subnet_suffixes))

  public_subnet_cidrs = {
    for idx, az in local.public_azs :
    az => cidrsubnet(var.cidr_block, 8, var.public_subnet_suffixes[idx])
  }

  private_subnet_cidrs = {
    for idx, az in local.private_azs :
    az => cidrsubnet(var.cidr_block, 8, var.private_subnet_suffixes[idx])
  }
}


resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = merge(
    {
      Name = "main-vpc"
    },
    var.tags
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    {
      Name = "main-igw"
    },
    var.tags
  )
}

resource "aws_subnet" "public" {
  for_each = local.public_subnet_cidrs

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = merge(
    {
      Name = "public-subnet-${each.key}"
    },
    var.tags
  )
}

resource "aws_subnet" "private" {
  for_each = local.private_subnet_cidrs
  map_public_ip_on_launch = false


  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = merge(
    {
      Name = "private-subnet-${each.key}"
    },
    var.tags
  )
}

resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  vpc = true




  tags = merge(
    {
      Name = "nat-eip-${each.key}"
    },
    var.tags
  )
}

resource "aws_nat_gateway" "this" {
  for_each = aws_subnet.public

  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id

  tags = merge(
    {
      Name = "nat-gateway-${each.key}"
    },
    var.tags
  )

  depends_on = [aws_internet_gateway.this]
} 

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(
    {
      Name = "public-rt"
    },
    var.tags
  )
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  for_each = aws_subnet.private

  vpc_id = aws_vpc.this.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.this[each.key].id
  }

  tags = merge(
    {
      Name = "private-rt-${each.key}"
    },
    var.tags
  )
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private[each.key].id
}
