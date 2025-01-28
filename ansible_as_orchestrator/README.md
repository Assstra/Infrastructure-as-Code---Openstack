# Ansible as provider

You can use Ansible as a provider for Openstack to deploy your infrastructure. This is useful if you want to use Ansible to configure your instances ans don't want to use terraform.

Here are the commands to deploy the virtual machine on Openstack:

1. Install requirements (openstack provider)

```bash
ansible-galaxy collection install -r requirements.yml
```

2. Deploy the virtual machine

```bash
ansible-playbook machine.yml
```