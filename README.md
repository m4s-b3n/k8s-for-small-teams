# k8s-for-small-teams

Demo for k8s usage in small teams.

The repository contains an ansible playbook to setup a fully working k8s cluster on ubuntu with GitHub Action Runners deployed for the Repository itself and an additional application Repository.

![Target State](./docs/target_state.jpg)

The repository contains workflows to setup the k8s cluster:

```mermaid
flowchart TD
    subgraph Workflow
        START@{ shape: circle, label: "Start" }
        START --> VM_SUB
        style START fill:#dedede
        subgraph VM_SUB[Create Virtual Machine]
            direction LR
            style VM_SUB fill:#ffedd9
            TERRAFORM("Terraform: Create Azure Virtual Machine")
            TERRAFORM_NOTE@{ shape: odd, label: "As this is a demo the workflow initially a virtual machine needs to be created.
            Skip this if you already have a VM." }
            TERRAFORM -.- TERRAFORM_NOTE
        end
        VM_SUB --> |"VM Available Through SSH"| K8S_SUB
        subgraph K8S_SUB[Setup k8s]
            direction LR
            style K8S_SUB fill:#ffba70
            subgraph K8S_SUB_SUB[" "]
                style K8S_SUB_SUB fill:#ffba70,stroke:black,stroke-dasharray: 2 2
                ANSIBLE(Ansible: Setup microk8s on VM and Deploy Repo Runner)
                ANSIBLE --> |k8s cluster and repo runner available| TEST
                TEST(Actions: Test Repo Runner)
            end
            K8S_NOTE@{ shape: odd, label: "Prepare your machine.
            All you need is:
                1. An Ubuntu VM accessible by an SSH key.
                2. The SSH key to access The VM" }
            K8S_SUB_SUB -.- K8S_NOTE
        end
        K8S_SUB --> |"k8s Cluster With Deployment Runner Available"| DEPLOY_SUB
        subgraph DEPLOY_SUB[Deploy To k8s]
            style DEPLOY_SUB fill:#fc8403
            DEPLOY(Actions: Deploy additional k8s Resources)
            DEPLOY_NOTE@{ shape: odd, label: "Deploy any initial or additional resources here.
            As you have a runner within the k8s cluster you do not need any auth secrets.
            Utilizing GitHub Actions you have all your favorite tools (such as helm, kustomize, etc.) available..." }
            DEPLOY -.- DEPLOY_NOTE
        end
        DEPLOY_SUB --> STOP
        STOP@{ shape: circle, label: "Success" }
    end
```

<!-- markdownlint-disable -->

> [!IMPORTANT]
> The initial setup of a virtual machine in azure is just for demo purpose. If you plan to run your application in Azure consider using [Azure Kubernetes Service](https://learn.microsoft.com/de-de/azure/aks/what-is-aks), [Azure Container Instances](https://learn.microsoft.com/en-us/azure/container-instances/container-instances-overview) or [Azure Container Apps](https://learn.microsoft.com/en-us/azure/container-apps/overview).

> [!TIP]
> All workflow steps can be customized. Have a look at the terraform variables, the ansible variables or just deploy your own k8s resources in the last step.

<!-- markdownlint-enable -->

## Quickstart

Deploy to azure using thw workflow [![Deploy](https://github.com/m4s-b3n/k8s-for-small-teams/actions/workflows/deploy.yml/badge.svg)](https://github.com/m4s-b3n/k8s-for-small-teams/actions/workflows/deploy.yml)

Do not forget to clean up your deployment using the workflow [![Cleanup](https://github.com/m4s-b3n/k8s-for-small-teams/actions/workflows/cleanup.yml/badge.svg)](https://github.com/m4s-b3n/k8s-for-small-teams/actions/workflows/cleanup.yml)

### Access Grafana

The demo will deploy a monitoring solution using prometheus/grafana.

The grafana dashboard will be available under the following endpoint:

URL: [https://monitoring-demo-k8s-for-small-teams.northeurope.cloudapp.azure.com](https://monitoring-demo-k8s-for-small-teams.northeurope.cloudapp.azure.com)

Default User: admin

Default Password: prom-operator
