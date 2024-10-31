---
# cloud-config
package_update: true
package_upgrade: true
write_files:
  - path: /etc/ansible/group_vars/all
    content: |
      microk8s_user: ${admin_username}
      microk8s_modules:
        - dns
        - ingress
        - hostpath-storage        
        - metallb ${vnet_address_space}
  - path: /etc/ansible/hosts
    content: |
      all:
        hosts:
          localhost:
            ansible_connection: local
ansible:
  package_name: ansible-core
  install_method: distro
  pull:
    url: "https://github.com/m4s-b3n/k8s-for-small-teams.git"
    playbook_name: ansible/microk8s.yaml