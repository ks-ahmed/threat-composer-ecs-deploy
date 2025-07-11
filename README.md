# Containerized Application Deployment on AWS

### This project is based on Amazon's Threat Composer Tool, an open source tool designed to facilitate threat modeling and improve security assessments. 
You can explore the tool's dashboard here: Threat Composer Tool



This repository contains the Terraform infrastructure and Docker configuration to deploy a simple containerized web application on AWS ECS Fargate with an Application Load Balancer (ALB).

---

## Project Overview

The goal of this assignment is to demonstrate proficiency with:

- Docker containerization  
- AWS ECS Fargate service deployment  
- Infrastructure as Code with Terraform  
- Setting up networking, security groups, and load balancers  
- Automating deployments via GitHub Actions  

The deployed app is a web service running inside a Docker container, exposed via an ALB with HTTPS support.

---

<img width="2767" height="599" alt="image" src="https://github.com/user-attachments/assets/ec8883f6-6c48-407b-8966-983ad1d21301" />

---

## ECS Threat Modelling Tool

To better understand and mitigate security risks in your ECS deployment, this project integrates or references the **ECS Threat Modelling Tool**. This tool helps analyze the security posture of your ECS architecture by:

- **Identifying potential threats** specific to containerized environments, such as privilege escalation, container escape, and insecure network communication.  
- **Visualizing the attack surface** for your ECS tasks, services, and networking setup.  
- **Assessing IAM role permissions and network policies** to highlight over-privileged roles or open access points.  
- **Providing actionable recommendations** for hardening your ECS deployment, including least privilege enforcement, secure container images, and encrypted traffic.  

Using the ECS Threat Modelling Tool allows you to proactively secure your infrastructure, ensuring that your ECS workloads run safely and compliantly on AWS.

---

## Architecture

<img width="5032" height="1527" alt="image" src="https://github.com/user-attachments/assets/90aa1991-d094-4cdd-870a-f9aada3b1506" />

---

             

- **VPC:** Custom VPC with public subnets  
- **Security Groups:** Allow HTTP/HTTPS ingress, outbound traffic open  
- **Load Balancer:** Application Load Balancer with HTTPS listener (ACM cert)  
- **ECS:** Fargate launch type with task definition running the container  
- **Docker:** App container built and pushed to AWS ECR  
- **Terraform:** Manages all AWS resources as code  

---

## Prerequisites

- AWS Account with appropriate permissions  
- Terraform installed (v1.0+)  
- AWS CLI configured with credentials  
- Docker installed locally for building images  
- GitHub account for CI/CD (optional)

---

## Setup Instructions

1. **Clone this repository:**

   ```bash
   git clone https://github.com/CoderCo-Learning/ecs-assignment.git
   cd ecs-assignment

