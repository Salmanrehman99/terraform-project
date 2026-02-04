🛒 GroceryMate — Cloud-Native Grocery Platform

A hands-on cloud engineering project built to explore AWS infrastructure, backend services, and Terraform-based automation.

📖 Project Summary

GroceryMate is a cloud-hosted grocery shopping platform designed as a learning-focused project to practice deploying and managing a modern web application on AWS.

The project emphasizes:

Infrastructure as Code (IaC) using Terraform

Secure backend development

Cloud resource design with scalability and cost-awareness

Practical experience integrating databases, APIs, and cloud services

Rather than focusing on UI polish, this project prioritizes architecture, deployment strategy, and backend reliability.

🧠 What This Project Demonstrates

Cloud deployment of a multi-component application

Backend API development using Python

Secure user authentication and access control

PostgreSQL database integration

Terraform-managed AWS infrastructure

Practical DevOps-style workflows

This repository represents a reimplementation and customization created for personal learning and experimentation.

🧩 Core Functionality

User Accounts & Authentication

Secure registration and login

Token-based authentication for protected endpoints

Product Browsing

View grocery items

Filter and sort by category and price

Basket Management

Add or remove products

Adjust quantities dynamically

Checkout Logic

Price calculation

Order finalization flow (no real payments)

🖼️ Application Preview

Below are example screenshots from the running application:




🛠️ Technologies Used
Layer	Tools & Services
Backend	Python, Flask
Database	PostgreSQL
Cloud Platform	AWS
Infrastructure	Terraform
Version Control	Git
🔧 Local Setup Guide
1️⃣ Get the Code
git clone --branch version2 https://github.com/AlejandroRomanIbanez/AWS_grocery.git
cd AWS_grocery

2️⃣ Database Preparation (PostgreSQL)

Create the database and user manually to retain full control over credentials.

psql -U postgres -c "CREATE DATABASE grocerymate_db;"
psql -U postgres -c "CREATE USER grocery_user WITH ENCRYPTED PASSWORD '<secure_password>';"
psql -U postgres -c "ALTER USER grocery_user WITH SUPERUSER;"


Replace <secure_password> with your own strong password.

3️⃣ Import Initial Data
psql -U grocery_user -d grocerymate_db -f backend/app/sqlite_dump_clean.sql


Optional verification:

psql -U grocery_user -d grocerymate_db -c "SELECT * FROM users;"
psql -U grocery_user -d grocerymate_db -c "SELECT * FROM products;"

4️⃣ Python Environment Setup
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

5️⃣ Environment Configuration

Set required environment variables (example):

export DATABASE_URL=postgresql://grocery_user:<password>@localhost/grocerymate_db
export SECRET_KEY=your_secret_key

6️⃣ Run the Application
python run.py


The backend will be available locally once started.

☁️ AWS & Terraform Overview

This project uses Terraform to provision cloud infrastructure components such as:

Compute resources

Networking

Security groups

Database-related services

Terraform scripts are organized to encourage repeatable and auditable deployments.

⚠️ AWS resources may incur costs. Always review your AWS console.

🧪 Learning Goals & Design Decisions

Practice real-world cloud deployment workflows

Understand how infrastructure choices affect scalability and cost

Learn how backend services interact with cloud-managed resources

Explore Infrastructure as Code best practices

This project is intentionally designed to be educational, not production-ready.

🔮 Possible Extensions

Containerization using Docker

CI/CD pipeline integration

Role-based access control

Caching layer for performance

Monitoring and logging (CloudWatch)

📜 License

This repository is provided for educational purposes only.
You are free to explore, modify, and learn from it.
