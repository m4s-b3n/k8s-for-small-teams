# k8s-for-small-teams

Demo for k8s usage in small teams

## Setup with terraform

```bash
# switch to terraform dir
cd terraform

# init terraform
terraform init

# apply configuration
terraform apply -auto-approve

# ssh into machine
ssh -o StrictHostKeyChecking=no -i $(terraform output -raw ssh_private_key_file) $(terraform output -raw ssh_username)@$(terraform output -raw ssh_fqdn)
```
