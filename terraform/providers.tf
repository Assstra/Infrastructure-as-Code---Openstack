# Define required providers
terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

# Configure the OpenStack Provider
provider "openstack" {
  user_name = var.username
  password = var.password
  auth_url = "https://keystone-public-openstack.apps.osp.do.intra/"
  region = "regionOne"
  insecure = true
  user_domain_name = "Default"
  endpoint_overrides = {
    "identity"  = "https://keystone-public-openstack.apps.osp.do.intra/"
  }
}