
# VPC Public & Private Subnet Setup Using Terraform

## Prerequisites

- **Terraform**: Make sure Terraform is installed on your system. You can download it from [here](https://www.terraform.io/downloads).
- **AWS CLI**: Ensure AWS CLI is configured with the appropriate credentials. You can configure it using `aws configure` command.


### This repository contains Terraform code for creating an AWS VPC (Virtual Private Cloud) with the following configuration:

- **VPC**: A new VPC.
- **Subnets**: Two public subnet and two private subnet.
- **Internet Gateway**: Allows public subnet to access the internet.
- **NAT Gateway**: Allows the private subnet to access the internet.
- **Route Tables**: Routes for public and private subnets to access the internet via respective gateways.
- **Auto Scaling Groups**: Automatically scale your infrastructure based on traffic.
- **Security Groups**: Control traffic to and from resources within your VPC.
- **Load Balancers**: Ensure that the traffic is evenly distributed across your instances.

## Steps to Set Up

1. Clone the repository to your local machine:

   ```bash
   git clone https://github.com/your-repo/vpc-terraform.git
   cd vpc-terraform
   ```

2. Initialize the Terraform configuration:

   ```bash
   terraform init
   ```

3. Review the Terraform plan to ensure everything is configured as expected:

   ```bash
   terraform plan
   ```

4. Apply the Terraform configuration to create the VPC and subnets:

   ```bash
   terraform apply
   ```

   You will be prompted to confirm. Type `yes` and press Enter.

5. To destroy the resources when you are done, run:

   ```bash
   terraform destroy
   ```

## Notes

- This setup assumes you're using AWS as the cloud provider.
- Be cautious when running `terraform destroy`, as it will remove all the resources created by Terraform.
