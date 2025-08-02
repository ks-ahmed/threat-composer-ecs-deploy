# ECS: End-to-End DevSecOps on AWS

## Threat Modelling Tool – Overview

Welcome to the **Threat Modelling Tool**, a containerized web application designed for teams to collaboratively identify and manage security threats. Built for the cloud, this project leverages **AWS ECS Fargate** for serverless container orchestration, enabling scalable, consistent deployments across all environments.

The application runs inside **private subnets**, ensuring that core services are isolated from public access. All inbound traffic is routed through an **Application Load Balancer (ALB)** in a public subnet, enforcing **security through obscurity** by minimizing surface area and exposure. HTTPS is enforced via **AWS Certificate Manager (ACM)**, with **Cloudflare DNS** handling secure and reliable domain resolution.

Infrastructure is fully automated with **Terraform** and **GitHub Actions**, enabling repeatable, versioned deployments using **Infrastructure as Code (IaC)**. Docker images are built and pushed to **Amazon ECR**, then deployed securely through CI/CD pipelines. IAM policies follow **least-privilege** principles, and the system is modular, scalable, and fault-tolerant by design.

This architecture exemplifies modern **DevSecOps** practices—combining automation, scalability, and strong security posture into a production-ready cloud solution.


### Live Demo:


https://github.com/user-attachments/assets/7c7b4f44-b98c-4e29-8acc-9d493eb4ed87


---

## Key Highlights

- **Private Subnet Isolation**: All ECS workloads are deployed in **private subnets**, preventing any direct exposure to the internet. Traffic reaches the application **only through an Application Load Balancer (ALB)** in the public subnet.
- **Dockerized Frontend**: A React-based web interface, containerized for consistent deployments.
- **Infrastructure as Code**: Fully managed using **Terraform**, broken into reusable modules.
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
  - Cloudflare DNS entrypoint
  - IAM Gateway components

- **Private Subnet (eu-west-b)** hosts:
  - **ECS Fargate tasks** for application workload
  - **NAT Gateway** for outbound-only internet access
  - **Amazon S3** for storing assets and remote backend state
  - No inbound internet traffic allowed

This design ensures that application containers are **not directly accessible** from the internet, reducing the attack surface and following **zero-trust architecture principles**.

---


## Architecture Diagram

![tm-app2](https://github.com/user-attachments/assets/2044a4cb-8746-459c-a4ca-3df7d3081d91)

> Includes ALB, ECS Fargate, ECR, ACM, GitHub Actions CI/CD, Cloudflare DNS, and IAM roles – all provisioned with Terraform.

> ECS Fargate runs in a private subnet. Public traffic is routed through Cloudflare → ALB → ECS tasks via HTTPS.

---

### Automated Backend Provisioning (S3 with Object Lock)

The `backend` Terraform module at `terraform/modules/backend` provisions a secure, centralized remote backend using **Amazon S3**, enabling versioned and tamper-resistant Terraform state management — without requiring DynamoDB.

Key components:

- **S3 Bucket**
  - Configured with **Object Lock (Governance Mode)** for **immutable state protection**
  - **Versioning enabled** to preserve historical state files and support recovery
  - **Server-side encryption** (SSE-S3 or SSE-KMS) for data-at-rest protection
  - Optional **bucket policy restrictions** to control access by IAM role or condition

This setup provides:

- **Centralized state**: Shared across teams and CI/CD pipelines  
- **Tamper protection**: Using S3 Object Lock to prevent accidental or malicious state deletion/modification  
- **Auditability**: S3 versioning enables historical tracking of changes  
- **Automation ready**: Ideal for CI/CD pipelines using GitHub Actions or other runners



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

<img width="1504" height="777" alt="Screenshot 2025-07-12 114303" src="https://github.com/user-attachments/assets/5a2cbb57-d53f-4717-9000-e0763de5ac69" />

---

<img width="1559" height="815" alt="Screenshot 2025-07-12 114352" src="https://github.com/user-attachments/assets/fb2b813c-d60a-438e-8e2a-6ce7ba10cee6" />

---

<img width="1563" height="802" alt="Screenshot 2025-07-12 114404" src="https://github.com/user-attachments/assets/1054f59a-cb8b-486a-8cdd-84399e8ef451" />

---

<img width="1613" height="808" alt="Screenshot 2025-07-12 114506" src="https://github.com/user-attachments/assets/ff20c503-ff39-4492-b990-fded933383fa" />

---

<img width="1455" height="605" alt="Screenshot 2025-07-12 114828" src="https://github.com/user-attachments/assets/ad69c62e-cb32-47c5-81c2-dad6e40d215f" />


---

<img width="1877" height="1056" alt="Screenshot 2025-07-12 114003" src="https://github.com/user-attachments/assets/31388eba-fe41-49ac-992b-7a1af38eaf03" />


---

## 🧪 Local Development Setup

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
- End-to-end cloud architecture deployment using AWS services like ECS (Fargate), ALB, ACM, ECR, IAM, and VPC
- Modular Infrastructure as Code (IaC) with Terraform, allowing scalable, reusable, and maintainable infrastructure components
- CI/CD automation through GitHub Actions, orchestrating Docker image builds, ECR pushes, and infrastructure provisioning workflows

### Enterprise-Level Security
- HTTPS enforcement with AWS Certificate Manager (ACM)
- IAM roles configured using the principle of least privilege
- Domain-level protection and secure traffic routing using Cloudflare DNS

### Real-World Scenario Simulation
This project simulates how organizations deploy cloud-native applications with full infrastructure automation, pipeline integration, and robust security, making it ideal for:

- Showcasing hands-on DevOps and cloud engineering proficiency
- Highlighting secure, scalable, and automated AWS deployments
- Demonstrating professional readiness for infrastructure-focused roles


# License
MIT License — feel free to use, fork, and deploy.









