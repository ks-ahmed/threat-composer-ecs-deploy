# ECS: End-to-End DevSecOps on AWS

[![Terraform](https://img.shields.io/badge/IaC-Terraform-623CE4?logo=terraform&logoColor=white)](https://www.terraform.io/)
[![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub_Actions-2088FF?logo=githubactions&logoColor=white)](https://github.com/features/actions)
[![Docker](https://img.shields.io/badge/Container-Docker-2496ED?logo=docker&logoColor=white)](https://www.docker.com/)
[![AWS](https://img.shields.io/badge/Cloud-AWS-FF9900?logo=amazonaws&logoColor=white)](https://aws.amazon.com/)

## Threat Modelling Tool – Overview

Welcome to the **Threat Modelling Tool**, a containerised web application designed for teams to collaboratively identify and manage security threats. Built for the cloud, this project leverages **AWS ECS Fargate** for serverless container orchestration, enabling scalable, consistent deployments across all environments.

The application runs inside **private subnets**, ensuring that core services are isolated from public access. All inbound traffic is routed through an **Application Load Balancer (ALB)** in a public subnet, enforcing **security through obscurity** by minimising surface area and exposure. HTTPS is enforced via **AWS Certificate Manager (ACM)**, with **Cloudflare DNS** handling secure and reliable domain resolution.

Infrastructure is fully automated with **Terraform** and **GitHub Actions**, enabling repeatable, versioned deployments using **Infrastructure as Code (IaC)**. Docker images are built and pushed to **Amazon ECR**, then deployed securely through CI/CD pipelines. IAM policies follow **least-privilege** principles, and the system is modular, scalable, and fault-tolerant by design.

This architecture exemplifies modern **DevSecOps** practices—combining automation, scalability, and a strong security posture into a production-ready cloud solution.



### Live Demo:

https://github.com/user-attachments/assets/f50dbf89-b2a2-4fd8-9308-192e3773d157


---

## Key Highlights

- **Private Subnet Isolation**: All ECS workloads are deployed in **private subnets**, preventing any direct exposure to the internet. Traffic reaches the application **only via an Application Load Balancer (ALB)** in the public subnet.
- **Containerised Frontend**: A React-based web interface, containerised for consistent deployments.
- **Infrastructure as Code**: Fully managed using **Terraform**, structured into reusable modules.
- **CI/CD Pipeline**: GitHub Actions automates building, pushing Docker images to **Amazon ECR**, and provisioning infrastructure.


---

## Technologies Used

| Category       | Tools/Services                             |
|----------------|---------------------------------------------|
| **Cloud**      | AWS ECS (Fargate), ALB, ECR, ACM, VPC       |
| **DNS & TLS**  | Cloudflare DNS, ACM TLS Certs               |
| **IaC**        | Terraform (Modular, multi-region)           |
| **CI/CD**      | GitHub Actions (Build, Deploy, Destroy)     |
| **Security**   | IAM, SSL, Cloudflare proxying               |
| **Container**  | Docker (Multi-stage build)                  |

---
## Architecture Overview

This deployment leverages a **multi-subnet AWS VPC** setup to enforce **network segregation** and **enhance security**.

- **Public Subnet (eu-west-a)** hosts:
  - Application Load Balancer (ALB)
  - ACM Certificates
  - Cloudflare DNS entry point
  - IAM Gateway components

- **Private Subnet (eu-west-b)** hosts:
  - **ECS Fargate tasks** for application workload
  - **NAT Gateway** for outbound-only internet access
  - **Amazon S3** for storing assets and remote backend state
  - No inbound internet traffic permitted

This design ensures that application containers are **not directly accessible** from the internet, reducing the attack surface and aligning with **zero-trust architecture principles**.


## Architecture Diagram

---

<img width="3000" height="1240" alt="tm-appv2" src="https://github.com/user-attachments/assets/bc8288c6-89da-450b-abe1-8ea72bf2a44f" />

---

> Includes ALB, ECS Fargate, ECR, ACM, GitHub Actions CI/CD, Cloudflare DNS, and IAM roles – all provisioned with Terraform.

> ECS Fargate runs in a private subnet. Public traffic is routed through Cloudflare → ALB → ECS tasks via HTTPS.

---

### Automated Backend Provisioning (S3 with Object Lock)

The `backend` Terraform module at `terraform/modules/backend` provisions a secure, centralised remote backend using **Amazon S3**, enabling versioned and tamper-resistant Terraform state management — without requiring DynamoDB.

Key components:

- **S3 Bucket**
  - Configured with **Object Lock (Governance Mode)** for **immutable state protection**
  - **Versioning enabled** to preserve historical state files and support recovery
  - **Server-side encryption** (SSE-S3 or SSE-KMS) for data-at-rest protection
  - Optional **bucket policy restrictions** to control access by IAM role or condition

This setup provides:

- **Centralised state**: Shared across teams and CI/CD pipelines  
- **Tamper protection**: Using S3 Object Lock to prevent accidental or malicious state deletion/modification  
- **Auditability**: S3 versioning enables historical tracking of changes  
- **Automation-ready**: Ideal for CI/CD pipelines using GitHub Actions or other runners




# Project Architecture
---

```
├── app/                           
├── terraform/                     
│   ├── main.tf                    
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars         
│   ├── provider.tf                
│
│   ├── modules/                  
│   │   ├── backend/              
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── vpc/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── alb/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── ecs/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   ├── acm/
│   │   │   ├── main.tf
│   │   │   ├── variables.tf
│   │   │   └── outputs.tf
│   │   └── cloudflare_dns/
│   │       ├── main.tf
│   │       ├── variables.tf
│   │       └── outputs.tf
│
├── .github/
│   └── workflows/                
│       ├── build.yaml
│       ├── terraform-init-plan.yaml
│       ├── terraform-apply.yaml
│       └── terraform-destroy.yaml

```


## CI/CD Workflow Overview


```
# 📈 Deployment Workflow for ECS Threat Modeling Tool

# 1. Push code to main OR manually trigger the build workflow
echo "➡️ Step 1: Push code to main branch or manually trigger build.yaml"

# 2. GitHub Actions builds Docker image from /app and pushes to Amazon ECR
echo "➡️ Step 2: GitHub Actions builds Docker image from ./app and pushes to ECR"

# 3. Manually trigger Terraform workflows in the following order:
echo "➡️ Step 3: Trigger Terraform workflows manually via GitHub Actions UI"

echo "   a. terraform-init.yaml"
echo "   b. terraform-plan.yaml"
echo "   c. terraform-apply.yaml"

# 4. ECS Fargate is deployed with the latest container image from ECR
echo "➡️ Step 4: ECS Fargate runs the containerized app"

# 5. ALB routes incoming HTTPS traffic to ECS
echo "➡️ Step 5: ALB handles HTTPS and traffic forwarding to ECS tasks"

# 6. Cloudflare resolves DNS for tm.vettlyai.com and routes it to ALB
echo "➡️ Step 6: Cloudflare routes traffic from tm.vettlyai.com to ALB"
```

# Screenshots

---
<img width="1502" height="761" alt="Screenshot 2025-08-02 170657" src="https://github.com/user-attachments/assets/315eded0-beda-4ae9-81ef-167fd41d5e86" />


---

<img width="1499" height="831" alt="Screenshot 2025-08-02 170709" src="https://github.com/user-attachments/assets/9a09b5e8-abba-415a-83d5-df7c6199a0a5" />

---

<img width="1597" height="796" alt="Screenshot 2025-08-02 170838" src="https://github.com/user-attachments/assets/9b76267f-4444-4ff0-8755-92f2700360ea" />

---

<img width="1371" height="966" alt="Screenshot 2025-08-02 171245" src="https://github.com/user-attachments/assets/cdc6c381-5405-44fd-985f-b35df154a4aa" />

---

<img width="1338" height="776" alt="Screenshot 2025-08-02 171304" src="https://github.com/user-attachments/assets/62a4c54e-a07f-4512-8373-755fc191ad0d" />


---

<img width="1884" height="1060" alt="Screenshot 2025-08-02 170849" src="https://github.com/user-attachments/assets/a1f461aa-ddc3-400b-bed8-fe5684fc7005" />


---

## Local Development Setup

You can run the app locally using Docker for development and testing:

### Prerequisites

- [Docker](https://www.docker.com/)
- [Node.js](https://nodejs.org/)
- [GitHub CLI](https://cli.github.com/) (for GitHub Actions if needed)

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/your-org/threat-modelling-tool.git
cd threat-modelling-tool

# 2. Navigate to the app directory
cd app

# 3. Install dependencies
npm install

# 4. Run the app in local dev mode
npm start

# OR run it as a Docker container:
docker build -t tm-app .
docker run -p 8080:8080 tm-app
```

## Why This Project?

This project was developed to replicate a real-world, production-grade cloud deployment of a secure web application using modern DevOps principles and best practices.

It serves as a comprehensive demonstration of:

### Practical DevOps Expertise
- End-to-end cloud architecture deployment using AWS services such as ECS (Fargate), ALB, ACM, ECR, IAM, and VPC
- Modular Infrastructure as Code (IaC) with Terraform, enabling scalable, reusable, and maintainable infrastructure components
- CI/CD automation via GitHub Actions, orchestrating Docker image builds, ECR pushes, and infrastructure provisioning workflows

### Enterprise-Level Security
- HTTPS enforcement with AWS Certificate Manager (ACM)
- IAM roles configured according to the principle of least privilege
- Domain-level protection and secure traffic routing using Cloudflare DNS

### Real-World Scenario Simulation
This project simulates how organisations deploy cloud-native applications with full infrastructure automation, pipeline integration, and robust security—making it ideal for:

- Showcasing hands-on DevOps and cloud engineering proficiency
- Highlighting secure, scalable, and automated AWS deployments
- Demonstrating professional readiness for infrastructure-focused roles


# License
MIT License — feel free to use, fork, and deploy.









