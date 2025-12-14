PRE-REQUISITES
AWS account
EC2 machine with desired intsnace type
Install Terraform
Clone repository
Make necessary adjustments and run the below commands


Commands
Terraform plan with desired keyname and nodes
Terraform plan -var "key_name=(desired keyfile) -var "servercount=(desired node) -out (desired output name)
Terraform apply (desired output name)
