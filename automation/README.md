# Dev Information

## Setup Azure VM with Terraform

```bash
# switch to terraform dir
cd terraform

# init terraform
terraform init

# for SSH access
export TF_VAR_vm_local_keyfile="~/.ssh/key.pem"

# apply configuration
terraform apply -auto-approve

# SSH into machine
ssh -o StrictHostKeyChecking=no -i $(terraform output -raw ssh_private_key_file) $(terraform output -raw ssh_username)@$(terraform output -raw ssh_fqdn)
```

## Access VM with SSH

Assuming the username and DNS labels have not been changed and you added the SSH key to your SSH agent you can access the VM with:

`ssh -o StrictHostKeyChecking=no azureuser@app-demo-k8s-for-small-teams.northeurope.cloudapp.azure.com`

## Access Grafana

URL: [grafana](http://monitoring-demo-k8s-for-small-teams.northeurope.cloudapp.azure.com/login)

Get Username: `kubectl -n observability get secret kube-prom-stack-grafana -o jsonpath='{.data.admin-user}' | base64 -d`)

Get Password: `kubectl -n observability get secret kube-prom-stack-grafana -o jsonpath='{.data.admin-password}' | base64 -d`

## Setup MicroK8s manually

```bash
# setup
sudo snap install microk8s --classic

# join group
sudo usermod -a -G microk8s $USER
mkdir -p ~/.kube
chmod 0700 ~/.kube
sudo su - $USER

# wait till ready
microk8s status --wait-ready

# test
microk8s kubectl get nodes

# add core-dns
microk8s enable dns

# add ingress
microk8s enable ingress

# add hostpath-storage
microk8s enable hostpath-storage

# add metallb
export ADDRESS_SPACE=<ADDRESS_SPACE>
microk8s enable metallb $ADDRESS_SPACE

# add alias
echo "alias kubectl='microk8s kubectl'" >> ~/.bash_aliases
source ~/.bash_aliases
```

## Access VM

```bash
export KEYVAULT_NAME=<>
export SECRET_NAME=k8s-for-small-teams-key
export KEY_FILE=~/.ssh/id_rsa_k8s-for-small-teams

export VM_RESOURCE_GROUP=rg-k8s-for-small-teams
export VM_NAME=vm-k8s-for-small-teams
export VM_USER=azureuser

# Download private key
az keyvault secret show --vault-name "$KEYVAULT_NAME" --name "$SECRET_NAME" --query "value" -o json | jq -r . > $KEY_FILE

# SSH
az ssh vm --private-key-file $KEY_FILE --resource-group $VM_RESOURCE_GROUP --name $VM_NAME --local-user $VM_USER
```
