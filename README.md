This repository provides an automated, infrastructure-as-code approach for deploying a production-ready Ansible Controller on AWS using Terraform. It provisions an EC2 instance, security groups, variables, and templates. Adjust values in `variable.tf`, run `terraform plan`, and apply the output to deploy. Ensure AWS credentials, Terraform, and an EC2 key pair are configured before use.

Overview
•	- EC2 instance provisioning
•	- Security group configuration
•	- Customizable node count
•	- Terraform-driven workflow for consistent deployments

Production Ready Ansible Controller Deployment with Terraform
This repository provides an automated, infrastructure-as-code approach for deploying a production-ready Ansible Controller on AWS using Terraform. It is designed for engineers who want a repeatable, scalable, and secure way to stand up an Ansible control node with minimal manual effort.

Overview
The project provisions:
•	An EC2 instance sized according to your needs
•	A security group configured for controller access
•	A customizable number of nodes
•	A Terraform driven workflow for consistent deployments

All infrastructure definitions are written in HCL, with variables exposed for easy customization.

Pre Requisites
Before deploying, ensure you have:
•	An active AWS account
•	Terraform installed locally
•	An EC2 key pair available
•	This repository cloned to your machine

Usage
Clone the repository
git clone <repo-url>
cd Ansible-project

Adjust variables
Update values in variable.tf or pass them via CLI

Run Terraform plan
terraform plan \
  -var "key_name=<your-keyfile>" \
  -var "servercount=<desired-node-count>" \
  -out <output-name>

     Apply the plan
     terraform apply <output-name>


