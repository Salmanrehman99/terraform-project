

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
# Create a PostgreSQL database
psql -U <postgres_admin_user> -c "CREATE DATABASE <your_database_name>;"

# Create a new PostgreSQL user with a secure password
psql -U <postgres_admin_user> -c "CREATE USER <your_database_user> WITH ENCRYPTED PASSWORD '<your_secure_password>';"

# Grant superuser privileges (optional, adjust based on security requirements)
psql -U <postgres_admin_user> -c "ALTER USER <your_database_user> WITH SUPERUSER;"

```

### 🔹 Populate Database

```sh
psql -U <your_database_user> -d <your_database_name> -f <path_to_sql_file>
```

Verify insertion:

```sh
# Verify data in users table
psql -U <your_database_user> -d <your_database_name> -c "SELECT * FROM users;"

# Verify data in products table
psql -U <your_database_user> -d <your_database_name> -c "SELECT * FROM products;"
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
# ------------------------
# Authentication
# ------------------------
JWT_SECRET_KEY=<your_jwt_secret_key>

# ------------------------
# PostgreSQL Database
# ------------------------
POSTGRES_USER=<your_postgres_username>
POSTGRES_PASSWORD=<your_postgres_password>
POSTGRES_DB=<your_postgres_database_name>
POSTGRES_HOST=<your_postgres_host>
POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}

# ------------------------
# AWS Configuration
# ------------------------
AWS_REGION=<aws_region>
AWS_ACCESS_KEY_ID=<aws_access_key_id>
AWS_SECRET_ACCESS_KEY=<aws_secret_access_key>

# ------------------------
# S3 Bucket for User Files
# ------------------------
S3_BUCKET_NAME=<s3_bucket_name>
S3_BUCKET_REGION=<s3_bucket_region>
S3_AVATAR_PREFIX=<s3_avatar_prefix>

# ------------------------
# EC2 Key Pair
# ------------------------
EC2_KEY_NAME=<ec2_key_pair_name>
PUBLIC_KEY_PATH=<path_to_public_key_file>

# ------------------------
# Optional: Flask Environment
# ------------------------
FLASK_ENV=<flask_environment>
ENVIRONMENT=<environment_name>

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
| Cloud Provider         | AWS        | aws_region                       |
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
AWS_REGION=aws_region
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=

# S3 (User Avatars)
S3_BUCKET_NAME= your-bucket- name
S3_BUCKET_REGION= selected-bucket-region
S3_AVATAR_PREFIX=avatars/

# Database
POSTGRES_USER=grocery_user
POSTGRES_PASSWORD=your_password
POSTGRES_DB=your_postgres_database_name
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




## 📖  Future Improvements

Add CI/CD pipeline (GitHub Actions)

Containerize the application using Docker

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
