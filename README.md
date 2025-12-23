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

```bash
git clone https://github.com/Salmanrehman99/terraform-project.git
cd terraform-project

🔹 Configure PostgreSQL

Before creating the database user, replace <your_password> with a strong password.

psql -U postgres -c "CREATE DATABASE grocerymate_db;"
psql -U postgres -c "CREATE USER grocery_user WITH ENCRYPTED PASSWORD '<your_password>';"
psql -U postgres -c "ALTER USER grocery_user WITH SUPERUSER;"

🔹 Populate Database
psql -U grocery_user -d grocerymate_db -f backend/app/sqlite_dump_clean.sql


Verify insertion:

psql -U grocery_user -d grocerymate_db -c "SELECT * FROM users;"
psql -U grocery_user -d grocerymate_db -c "SELECT * FROM products;"

🔹 Set Up Python Environment
cd backend
pip install -r requirements.txt


If pip is not available:

pip3 install -r requirements.txt

🔹 Set Environment Variables

Create a .env file:

touch .env  # macOS/Linux
ni .env -Force  # Windows PowerShell


Generate a secure JWT key:

python3 -c "import secrets; print(secrets.token_hex(32))"


Update .env:

JWT_SECRET_KEY=<your_generated_key>
POSTGRES_USER=grocery_user
POSTGRES_PASSWORD=<your_password>
POSTGRES_DB=grocerymate_db
POSTGRES_HOST=localhost
POSTGRES_URI=postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@${POSTGRES_HOST}:5432/${POSTGRES_DB}

🔹 Start the Application
python3 run.py


Access locally at: http://localhost:5000

📖 Usage

Register/Login to your account

Browse and search for products

Manage favorites and shopping basket

Proceed through the checkout process

☁️ AWS & Terraform Setup

This project includes Terraform-managed infrastructure for AWS:

Provision EC2 instances for backend

Manage PostgreSQL and storage resources

Implement cost-efficient and scalable architecture

Infrastructure can be recreated easily using Infrastructure as Code

🚀 Future Improvements

Add CI/CD pipeline (GitHub Actions)

Containerize the application using Docker

Implement CloudWatch monitoring

Improve IAM security policies

Add caching layer (Redis / ElastiCache)

📜 License

This project is licensed under the MIT License.
