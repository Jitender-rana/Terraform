# 🚀 Terraform EC2 Setup with Ubuntu + DevOps Deployment Demo

This repository provisions an EC2 instance on AWS using Terraform, and includes a mini DevOps project where a Node.js app is:

- Dockerized
- Pushed to Amazon ECR
- Deployed to ECS via GitHub Actions
- Monitored using New Relic

---

## 📦 Features

- EC2 instance with Ubuntu 22.04 (Jammy), type `t2.medium`
- Key pair authentication (default: `jiturana`)
- Security groups with custom port access (22, 443, 3000, 3001, 8090)
- GitHub Actions CI/CD pipeline to deploy to ECS
- New Relic APM integration via updated task definition

---

## 📁 Folder Structure

.
├── main.tf
├── variables.tf
├── aws/
│ └── config
├── .github/workflows/
│ └── deploy.yml
└── README.md

yaml
Copy
Edit

---

## 🔐 AWS Credentials Setup

In `aws/config`, add:

ini
[profile terraform_aws]
aws_access_key_id = YOUR_ACCESS_KEY
aws_secret_access_key = YOUR_SECRET_KEY
region = us-east-1
Then in your terminal:

bash
Copy
Edit
export AWS_PROFILE=terraform_aws
🔒 Do not commit credentials. Add aws/config to .gitignore.

🚀 How to Deploy
bash
Copy
Edit
terraform init
terraform plan
terraform apply
Push to GitHub to trigger the ECS deployment via GitHub Actions.

📈 Monitoring
New Relic Node.js agent is used in the ECS container

Metrics visible in your New Relic dashboard

🧹 Cleanup
bash
Copy
Edit
terraform destroy
