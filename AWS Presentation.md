# 🏁 AWS Project Presentation: GroceryMate

## 🏆 Project Overview
**GroceryMate** is a modern, full-featured e-commerce platform designed for seamless online grocery shopping. This project demonstrates a production-ready deployment on **Amazon Web Services (AWS)** using **Terraform** as Infrastructure as Code (IaC).

---

## 📸 Application Preview

| Landing Page | Product Search |
| :---: | :---: |
| ![App Screenshot](https://github.com/user-attachments/assets/ea039195-67a2-4bf2-9613-2ee1e666231a) | ![App Screenshot](https://github.com/user-attachments/assets/a87e5c50-5a9e-45b8-ad16-2dbff41acd00) |

---

## 🏗️ Cloud Architecture
The application follows a secure **Three-Tier Architecture** deployed in the `eu-central-1` (Frankfurt) region.

### 🛠️ Services Used & Why

| AWS Service | Resource Type | Why I Used It |
| :--- | :--- | :--- |
| **Amazon EC2** | `t2.micro` | **Compute:** Provides resizable capacity and full control over the OS. The `t2.micro` is ideal for development as it's Free Tier eligible while offering burstable CPU performance. |
| **Amazon RDS** | `db.t2.micro` | **Database:** Using a managed PostgreSQL service instead of self-hosting ensures high availability, automated backups, and security patching without manual overhead. |
| **Terraform** | IaC Tool | **Automation:** I used Terraform to define the infrastructure as code. This allows for repeatable, consistent deployments and prevents "configuration drift." |
| **Amazon VPC** | Networking | **Security:** Isolates the application in a private virtual network. Security Groups act as firewalls, ensuring only traffic on Port 5000 (App) and 22 (SSH) is permitted. |
| **Amazon S3** | Object Storage | **Assets:** Optimized for storing and serving static product images with 99.99% durability, reducing the storage load on the EC2 instance. |

---

## 📊 Cost Evaluation
Designed to stay within the **AWS Free Tier** limits:
* **EC2:** 750 hours/month of `t2.micro`.
* **RDS:** 750 hours/month of `db.t2.micro`.
* **EBS:** 8GB `gp3` storage (included in the 30GB free limit).

---

## 🚀 Key Features
* **🛡️ Secure Authentication**: JWT-based login and session management.
* **🔎 Product Discovery**: Real-time search and category filtering.
* **🛍️ Dynamic Cart**: Add, modify, and remove items with live price calculation.
* **☁️ Cloud Native**: Fully optimized for deployment on AWS infrastructure.

---

## 🔗 Project Links

* **GitHub Repository:** [https://github.com/Salmanrehman99/terraform-project.git](https://github.com/Salmanrehman99/terraform-project.git)
* **Live Demo:** [http://ec2-3-69-26-136.eu-central-1.compute.amazonaws.com:5000](http://ec2-3-69-26-136.eu-central-1.compute.amazonaws.com:5000)

---

## ⚙️ Quick Start

### 1. Run Locally
```sh
pip install -r requirements.txt
python3 run.py
