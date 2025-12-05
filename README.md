# Terraform EC2 Simple Project

This canvas contains everything you asked for: the Terraform code files (`main.tf`, `variables.tf`, `outputs.tf`) plus a `README.md` you can use in the project root. Copy each file into your project folder and follow the run steps in the README.

## File: `README.md`

````md
# Terraform EC2 Simple Project

This project creates a single EC2 instance (Amazon Linux 2 by default) and outputs its Instance ID, Public IP, Availability Zone and AMI ID. It also creates a Security Group that allows SSH (TCP/22) from everywhere — **only use this for learning**.

## Files
- `main.tf` - main resources and data source
- `variables.tf` - variables and defaults
- `outputs.tf` - outputs to display after apply

## Defaults
- **Region:** `us-east-1`
- **Instance type:** `t2.micro`
- **Platform (AMI):** `amazon-linux` (set `platform = "ubuntu"` to use Ubuntu 22.04)
- **Instance name tag:** `terraform-ec2-sample`

> **Important:** Provide an existing EC2 Key Pair name in `var.key_name` so you can SSH into the instance. You can create a key pair in the AWS Console or with the AWS CLI: `aws ec2 create-key-pair --key-name mykey --query 'KeyMaterial' --output text > mykey.pem` (save securely, set permissions `chmod 400 mykey.pem`).

## Quick usage
1. Ensure AWS credentials are configured and working:
   ```bash
   aws sts get-caller-identity
````

2. Initialize Terraform:

   ```bash
   terraform init
   ```

3. (Optional) Preview what will be created:

   ```bash
   terraform plan -out plan.out
   ```

   *Take a screenshot of this command's stdout for your deliverable.*

4. Apply to create the instance:

   ```bash
   terraform apply -auto-approve
   ```

   *Take a screenshot showing the "Apply complete!" output.*

5. After apply completes, run:

   ```bash
   terraform output
   ```

   The outputs will include `instance_id`, `public_ip`, `availability_zone`, and `ami_id`. Save these values for your deliverable.

6. Confirm in the AWS Console: EC2 -> Instances. Take a screenshot showing the running instance (Instance ID, Name tag, and Public IP visible).

7. Destroy the resources when done:

   ```bash
   terraform destroy -auto-approve
   ```

   *Take a screenshot showing the destroy completed.*

## Notes for screenshots (what to capture)

* `terraform plan` output (the plan stdout). Save as `plan.png` (or similar).
* `terraform apply` completion (showing `Apply complete!`). Save as `apply_complete.png`.
* AWS Console showing the running instance list with Instance ID, Name, Public IP. Save as `console_instance.png`.
* `terraform destroy` completion. Save as `destroy_complete.png`.

<img width="1366" height="768" alt="Screenshot (10) - Copy" src="https://github.com/user-attachments/assets/c1612a27-595c-487e-8e3e-864b961fc1a9" /> <img width="1366" height="768" alt="Screenshot (9) - Copy" src="https://github.com/user-attachments/assets/c412b59b-41f4-4850-8e9b-7ac084b7e773" />
<img width="697" height="300" alt="Screenshot 2025-12-05 170135 - Copy" src="https://github.com/user-attachments/assets/ed037e13-39e6-4373-bf48-9c087ddaf044" />
<img width="1366" height="768" alt="Screenshot (11) - Copy" src="https://github.com/user-attachments/assets/bcedd369-c2ae-40de-ad5b-783b221a280d" />
<img width="1366" height="768" alt="Screenshot (12) - Copy" src="https://github.com/user-attachments/assets/a5ddc26d-a44d-42b0-99bb-787685268c24" />

<img width="1198" height="555" alt="image" src="https://github.com/user-attachments/assets/91af52b9-64ce-4a75-8fec-a270c23f7b2b" />



