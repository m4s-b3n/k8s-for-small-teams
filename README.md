# k8s-for-small-teams

Demo for k8s usage in small teams. Usually on-premise VMs are already present.

All you need is:
1. An ubuntu virtual machine
2. At least 2 DNS names for your machine
3. A SSH key to access the machine with root privileges

## Quickstart

Deploy to azure using thw workflow [![Deploy](https://github.com/m4s-b3n/k8s-for-small-teams/actions/workflows/deploy.yml/badge.svg)](https://github.com/m4s-b3n/k8s-for-small-teams/actions/workflows/deploy.yml)

Do not forget to clean up your deployment using the workflow [![Cleanup](https://github.com/m4s-b3n/k8s-for-small-teams/actions/workflows/cleanup.yml/badge.svg)](https://github.com/m4s-b3n/k8s-for-small-teams/actions/workflows/cleanup.yml)

## Dev

### Setup Azure VM with Terraform

```bash
# switch to terraform dir
cd terraform

# init terraform
terraform init

# for SSH access
export TF_VAR_vm_local_keyfile="~/.ssh/key.pem"

# apply configuration
terraform apply -auto-approve

# ssh into machine
ssh -o StrictHostKeyChecking=no -i $(terraform output -raw ssh_private_key_file) $(terraform output -raw ssh_username)@$(terraform output -raw ssh_fqdn)
```

### Access grafana

URL: [grafana](http://monitoring-demo-k8s-for-small-teams.northeurope.cloudapp.azure.com/login)

Get Username: `kubectl -n observability get secret kube-prom-stack-grafana -o jsonpath='{.data.admin-user}' | base64 -d`)

Get Password: `kubectl -n observability get secret kube-prom-stack-grafana -o jsonpath='{.data.admin-password}' | base64 -d`

### Setup MicroK8s manually

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
