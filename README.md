# ECS Threat Modelling Tool – End-to-End DevSecOps on AWS

# Threat Modelling Tool

Welcome to the **Threat Modelling Tool**, a fully containerized web application designed to provide teams with an intuitive platform for collaboratively identifying, mapping, and managing security threats within their applications. This project showcases a modern, production-grade cloud architecture built on Amazon Web Services (AWS) using ECS Fargate, a serverless container orchestration service that removes the need to manage servers, allowing the application to scale seamlessly based on demand. By leveraging containerization, the application ensures consistent, reliable deployments across development, testing, and production environments.

At the core of this project lies an automated infrastructure provisioning and deployment pipeline powered by **Terraform** and **GitHub Actions**. Terraform enables Infrastructure as Code (IaC), allowing you to define, version, and automate the complete cloud infrastructure lifecycle — from network setup with VPCs and security groups, to ECS clusters, Application Load Balancers, and ACM certificates for HTTPS. GitHub Actions orchestrate the CI/CD workflows that automate building Docker images, pushing them securely to Amazon ECR, and deploying infrastructure changes in a controlled, repeatable fashion. This end-to-end automation minimizes human error, accelerates release cycles, and enforces best practices in DevOps and cloud engineering.

Security and scalability are deeply integrated into every aspect of this project. HTTPS encryption is enforced using AWS Certificate Manager (ACM) combined with Cloudflare DNS to provide trusted, fast, and secure traffic routing. IAM roles and policies are carefully configured following the principle of least privilege, ensuring each component only has the permissions it needs. The architecture supports fault tolerance through auto-scaling ECS tasks behind an Application Load Balancer (ALB), while modular Terraform code promotes reusability and maintainability. This project not only demonstrates technical proficiency but also reflects real-world cloud deployment challenges and solutions, making it an excellent showcase of modern DevSecOps and cloud-native application delivery.

### Live Demo:


https://github.com/user-attachments/assets/7c7b4f44-b98c-4e29-8acc-9d493eb4ed87

---

## Project Overview

This project delivers a **secure threat modeling dashboard** designed to empower teams with a collaborative platform for mapping and managing application security threats. Key features include:

- **Containerized frontend application** built with React, providing an intuitive and responsive user interface
- **Scalable deployment** on AWS ECS Fargate, enabling automatic resource management and high availability
- **Robust HTTPS security** enforced through AWS Certificate Manager (ACM) and Cloudflare for encrypted, trusted communications
- **Automated infrastructure workflows** including DNS routing, SSL certificate provisioning, and end-to-end CI/CD pipelines for streamlined deployments

---

<img width="2767" height="599" alt="image" src="https://github.com/user-attachments/assets/ec8883f6-6c48-407b-8966-983ad1d21301" />

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


---

## Architecture Diagram

<img width="5032" height="1527" alt="image" src="https://github.com/user-attachments/assets/90aa1991-d094-4cdd-870a-f9aada3b1506" />

> Includes ALB, ECS Fargate, ECR, ACM, GitHub Actions CI/CD, Cloudflare DNS, and IAM roles – all provisioned with Terraform.

---

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


# How to Use (For Reviewers)

  - Clone the repo
  - Update terraform.tfvars or GitHub secrets
  - Trigger CI/CD pipelines on GitHub Actions
  - Access the app at: https://tm.vettlyai.com

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









