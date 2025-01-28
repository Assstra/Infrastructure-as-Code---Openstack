# Infrastructure & Configuration as Code

A project to test different tools to manage infrastructure and configuration as code.

---

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Heat](#heat)
3. [Ansible](#ansible)
4. [Terraform](#terraform)
5. [Kubernetes Cluster](#kubernetes-cluster)
6. [Useful Commands](#useful-commands)

---

## Prerequisites

This section guides you through setting up your user and project on OpenStack. The goal is to create a keypair and a security group to explore these features.

### Create a `clouds.yaml` File

To authenticate with Horizon, create a `~/.config/openstack/clouds.yaml` file. This file contains the credentials required to authenticate with the OpenStack API.

```yaml
clouds:
  openstack:
    auth:
      auth_url: <auth_url>
      username: <username>
      password: <password>
      project_id: <project_id>
      project_name: <project_name>
      user_domain_name: "Default"
    region_name: <region_name>
    interface: "public"
    identity_api_version: 3
    verify: false # Set to false if using a self-signed certificate
```

Export the `OS_CLOUD` environment variable to use the `openstack` CLI:

```bash
export OS_CLOUD=openstack
```

### Create a User

1. Open the Horizon dashboard.
2. Navigate to `Identity` > `Users` > `Create User`.
3. Fill in the form and click `Create User`.

**Note:** You may need to create a project to associate with your user.

### Create a Keypair

To access your VMs, create a keypair:

1. Open the Horizon dashboard.
2. Navigate to `Compute` > `Key Pairs` > `Create Key Pair`.
3. Fill in the form and click `Create Key Pair`.

---

## Heat

Guide to using OpenStack Heat for orchestration, including example commands.

The folder [heat](./heat) contains the Heat templates and configuration files to set up the infrastructure.

---

## Ansible

Guide to using Ansible for orchestration.

The folder [ansible_as_orchestrator](./ansible_as_orchestrator) contains the Ansible playbooks and configuration files to set up the infrastructure.

---

## Terraform

Instructions on using Terraform to start virtual machines for your frontend and backend, including network setup.

The folder [terraform](./terraform) contains the Terraform configuration files to set up the infrastructure.

---

## Kubernetes Cluster

Instructions for setting up a k3s cluster on OpenStack. This includes configuring ArgoCD to manage application manifests.

The folder [k3s](./k3s) contains the Kubernetes configuration files.

---

## Useful Commands

### OpenStack CLI

#### Add a Floating IP to an Instance

```bash
openstack server add floating ip <instance_name> <floating_ip>
```

#### Create a Security Group and Apply Rules

```bash
openstack security group create <sec_group_name>
openstack security group rule create --protocol <protocol> --dst-port <dest_port> --ingress <sec_group_name>
```

### SSH

Access your instance via SSH:

```bash
ssh -i <path_to_key> <default_user>@<ip_address>
```

