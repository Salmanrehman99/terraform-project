
# GroceryMate Cloud Platform

## 🏆 GroceryMate – Cloud-Based E-Commerce Application

[![Python](https://img.shields.io/badge/Language-Python%2C%20JavaScript-blue)](https://www.python.org/) 
[![Cloud](https://img.shields.io/badge/Cloud-AWS-orange)](https://aws.amazon.com/) 
[![Database](https://img.shields.io/badge/Database-PostgreSQL-336791)](https://www.postgresql.org/) 
[![Infrastructure](https://img.shields.io/badge/IaC-Terraform-purple)](https://www.terraform.io/)

⭐ If you find this project useful, feel free to star the repository.

---

## 📌 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Screenshots & Demo](#-screenshots--demo)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
  - [Clone Repository](#-clone-repository)
  - [Configure PostgreSQL](#-configure-postgresql)
  - [Populate Database](#-populate-database)
  - [Set Up Python Environment](#-set-up-python-environment)
  - [Set Environment Variables](#-set-environment-variables)
  - [Start the Application](#-start-the-application)
- [Usage](#-usage)
- [AWS & Terraform Setup](#-aws--terraform-setup)
- [How to Build & Run This Application](#-Building-running-app)
- [AWS Resources Used & Design Rationale](#-Resources-used)
- [Future Improvements](#-future-improvements)
- [License](#-license)

---

## 🚀 Overview

**GroceryMate** is a cloud-based e-commerce application for online grocery shopping.  
The project focuses on **AWS cloud deployment, Terraform-managed infrastructure, and backend development**, with attention to cost optimization, scalability, and security.

Users can browse grocery products, manage a shopping basket, and complete purchases through a secure backend. This version of the project was rebuilt and customized as a **personal learning project** to gain practical experience with **AWS services and Infrastructure as Code (Terraform)**.

---

## 🛒 Features

- **🛡️ User Authentication**: Secure registration and login with JWT.
- **🔒 Protected Routes**: Ensure only authenticated users access sensitive pages.
- **🔎 Product Search & Filtering**: Browse, filter, and sort products by category or price.
- **⭐ Favorites Management**: Save preferred products.
- **🛍️ Shopping Basket**: Add, view, modify, and remove items.
- **💳 Checkout Process**: Secure billing, multiple payment options, and automatic total price calculation.

---

## 📸 Screenshots & Demo

![App Screenshot](https://github.com/user-attachments/assets/ea039195-67a2-4bf2-9613-2ee1e666231a)  
![App Screenshot](https://github.com/user-attachments/assets/a87e5c50-5a9e-45b8-ad16-2dbff41acd00)  

---

## 📋 Prerequisites

Ensure the following are installed:

- **🐍 Python 3.11+**
- **🐘 PostgreSQL** – Database for storing product and user data
- **🛠️ Git**
- **☁️ AWS CLI**
- **🌍 Terraform**

---

## ⚙️ Installation

### 🔹 Clone Repository

```sh
git clone --branch version2 https://github.com/AlejandroRomanIbanez/AWS_grocery.git && cd AWS_grocery
```

### 🔹 Configure PostgreSQL

Before creating the database user, you can choose a custom username and password to enhance security. Replace `<your_secure_password>` with a strong password of your choice in the following commands.

Create database and user:

```sh
psql -U postgres -c "CREATE DATABASE grocerymate_db;"
psql -U postgres -c "CREATE USER grocery_user WITH ENCRYPTED PASSWORD '<your_secure_password>';"  # Replace <your_secure_password> with a strong password of your choice
psql -U postgres -c "ALTER USER grocery_user WITH SUPERUSER;"
```

### 🔹 Populate Database

```sh
psql -U grocery_user -d grocerymate_db -f backend/app/sqlite_dump_clean.sql
```

Verify insertion:

```sh
psql -U grocery_user -d grocerymate_db -c "SELECT * FROM users;"
psql -U grocery_user -d grocerymate_db -c "SELECT * FROM products;"
```

### 🔹 Set Up Python Environment


Install dependencies in an activated virtual Enviroment:

```sh
cd backend
pip install -r requirements.txt
```
OR (if pip doesn't exist)
```sh
pip3 install -r requirements.txt
```

### 🔹 Set Environment Variables

Create a `.env` file:

```sh
touch .env  # macOS/Linux
ni .env -Force  # Windows
```

Generate a secure JWT key:

```sh
python3 -c "import secrets; print(secrets.token_hex(32))"
```

Update `.env`:

```sh
nano .env
```

Fill in the following information (make sure to replace the placeholders):

```ini
JWT_SECRET_KEY=<your_generated_key>
POSTGRES_USER=grocery_user
POSTGRES_PASSWORD=<your_password>
POSTGRES_DB=grocerymate_db
POSTGRES_HOST=localhost
POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}
```

### 🔹 Start the Application

```sh
python3 run.py
```

## 📖 Usage

- Access the application at [http://localhost:5000](http://localhost:5000)
- Register/Login to your account
- Browse and search for products
- Manage favorites and shopping basket
- Proceed through the checkout process

## 📖 AWS & Terraform Setup

This project includes Terraform-managed infrastructure for AWS:

Provision EC2 instances for backend

Manage PostgreSQL and storage resources

Implement cost-efficient and scalable architecture

Infrastructure can be recreated easily using Infrastructure as Code

## 📖 How to Build & Run This Application
This section explains exactly how to build, configure, and run the GroceryMate application, including required versions, environment variables, infrastructure commands, and architecture.

| Component              | Technology | Version / Engine                |
| ---------------------- | ---------- | ------------------------------- |
| Backend                | Python     | **3.11+**                       |
| Web Framework          | Flask      | Latest (via `requirements.txt`) |
| Database               | PostgreSQL | **14+** (Engine: `postgres`)    |
| Frontend               | JavaScript | React-based                     |
| Cloud Provider         | AWS        | us-east-1                       |
| Infrastructure as Code | Terraform  | **≥ 1.5**                       |
| Storage                | Amazon S3  | Standard + Versioning           |
| Authentication         | JWT        | HS256                           |

The application relies on environment variables stored in a .env file inside the backend/ directory.
### 🔹Required Environment Variables:
# Application
FLASK_ENV=development
ENVIRONMENT=dev
JWT_SECRET_KEY=your_generated_secret

# AWS
AWS_REGION=us-east-1
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=

# S3 (User Avatars)
S3_BUCKET_NAME= your-bucket- name
S3_BUCKET_REGION= selected-bucket-region
S3_AVATAR_PREFIX=avatars/

# Database
POSTGRES_USER=grocery_user
POSTGRES_PASSWORD=your_password
POSTGRES_DB=grocerymate_db
POSTGRES_HOST=localhost
POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}

🐳 Docker (Planned)

Docker support is planned to simplify local development and deployment.

Future Docker usage will include:

Containerized Flask backend

PostgreSQL service via Docker Compose

Consistent development environments

🏗 Terraform Infrastructure Commands

All AWS infrastructure is managed using Terraform.
Initialize Terraform
terraform init
Preview Changes
terraform plan
Apply Infrastructure
terraform apply

Terraform provisions:

Amazon S3 bucket (avatars + versioning)

IAM roles & policies

PostgreSQL RDS

Networking resources (VPC-related components)

## 🏗 Architecture Diagram

The following diagram illustrates the high-level architecture of the GroceryMate cloud platform deployed on AWS.

![GroceryMate Architecture](Docs/architecture.png)

## 📖 AWS Resources Used & Design Rationale

This project uses several AWS services to build a scalable, secure, and production-like cloud architecture. Each service was chosen intentionally based on its strengths and real-world applicability.

🖥 Amazon EC2 – Backend Compute

Purpose:
Hosts the Python (Flask) backend API.

Why EC2?

Full control over the runtime environment

Cost-effective for small and medium workloads

Ideal for learning infrastructure fundamentals

Easily scalable to Auto Scaling Groups in the future

🐘 Amazon RDS (PostgreSQL) – Relational Database

Purpose:
Stores application data such as users, products, orders, and favorites.

Why RDS PostgreSQL?

Managed database service (automatic backups & patching)

Strong ACID compliance

Production-ready and widely adopted

Eliminates the need to manage database servers manually

Engine Used:

PostgreSQL 14+

🪣 Amazon S3 – Object Storage

Purpose:
Stores user-uploaded assets such as profile avatars.

Why S3?

Highly durable and scalable object storage

Cost-efficient for static files

Integrates securely with IAM roles

Supports versioning for data protection

Features Enabled:

Bucket versioning

IAM-scoped access policies

🔐 AWS IAM – Identity & Access Management

Purpose:
Manages secure access between AWS services.

Why IAM?

Enforces least-privilege access

Allows EC2 or Lambda to access S3 without hard-coded credentials

Improves security and follows AWS best practices

🌐 Amazon VPC – Networking

Purpose:
Provides isolated networking for AWS resources.

Why VPC?

Network isolation for security

Control over IP addressing and subnets

Foundation for scalable cloud architectures

Enables future expansion (load balancers, private subnets)

🧱 Terraform – Infrastructure as Code

Purpose:
Provisions and manages AWS resources.

Why Terraform?

Declarative and version-controlled infrastructure

Easy environment recreation

Prevents configuration drift

Industry-standard IaC tool

✅ Architecture Design Benefits

🔒 Secure – IAM-based access, isolated networking

📈 Scalable – Can evolve to Auto Scaling & Load Balancers

💰 Cost-Aware – Uses lightweight resources for development

🔁 Repeatable – Entire infrastructure can be recreated with Terraform

📌 Summary

The AWS services selected for this project closely mirror real production environments, making GroceryMate an excellent demonstration of cloud engineering best practices using AWS and Terraform.
This architecture was designed to balance simplicity, scalability, and real-world cloud practices while remaining cost-efficient for development environments.





## 📖  Future Improvements

Add CI/CD pipeline (GitHub Actions)

Containerize the application using Docker

Implement CloudWatch monitoring

Improve IAM security policies

Add caching layer (Redis / ElastiCache)

## 🤝 Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository.
2. Create a new feature branch (`feature/your-feature`).
3. Implement your changes and commit them.
4. Push your branch and create a pull request.

## 📜 License

This project is licensed under the MIT License.
