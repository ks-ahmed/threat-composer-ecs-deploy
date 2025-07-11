# ECS Threat Modelling Tool – End-to-End DevSecOps on AWS

Welcome to the **Threat Modelling Tool**, a fully containerized web application deployed securely on **AWS ECS (Fargate)** with end-to-end infrastructure automation using **Terraform** and **GitHub Actions**. Built for scalability, security, and automation – this project represents a production-grade DevSecOps pipeline with modern cloud architecture.

🔗 Live Demo: [https://tm.vettlyai.com](https://tm.vettlyai.com)

---

## Project Overview

This project is a **secure threat modelling dashboard** designed for teams to collaboratively map application security threats. It includes:
- A containerized frontend app (React-based)
- Auto-scaled deployment on ECS Fargate
- HTTPS secured via ACM + Cloudflare
- Automated DNS routing, cert provisioning, CI/CD workflows

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

## Architecture Diagram

<img width="5032" height="1527" alt="image" src="https://github.com/user-attachments/assets/90aa1991-d094-4cdd-870a-f9aada3b1506" />

> Includes ALB, ECS Fargate, ECR, ACM, GitHub Actions CI/CD, Cloudflare DNS, and IAM roles – all provisioned with Terraform.

---

## CI/CD Workflow Overview

All workflows are modular and triggered via `workflow_dispatch` or `push`. Built for auditability, safety, and repeatability.

### Build & Push Docker Image
```yaml
Trigger: push to main / manual dispatch
Steps:
- Checkout Code
- Login to AWS ECR
- Build & Tag Docker Image
- Push to ECR
```

# Terraform Init

`Trigger: Manual
Steps:
- Configure AWS Credentials
- Terraform init (infrastructure bootstrapping)`


# Terraform Plan

`Trigger: Manual
Steps:
- Plan infra changes using latest ECR image
- Show preview before apply`

# Terraform Apply

`Trigger: Manual
Steps:
- Apply infra changes (ECS service, ALB, ACM, etc.)`

# Terraform Destroy

`Trigger: Manual
Steps:
- Clean up all AWS resources`


# How to Use (For Reviewers)

  - Clone the repo
  - Update terraform.tfvars or GitHub secrets
  - Trigger CI/CD pipelines on GitHub Actions
  - Access the app at: https://tm.vettlyai.com

# Why This Project?

 - This project was built to simulate a real-world deployment scenario for a secure web application using DevOps best practices. It demonstrates:
 - Hands-on mastery of AWS infrastructure
 - Deep understanding of Terraform and modular design
 - CI/CD integration with Docker, GitHub Actions, and ECR
 - Attention to production-grade security (TLS, IAM, DNS)

# License
MIT License — feel free to use, fork, and deploy.









