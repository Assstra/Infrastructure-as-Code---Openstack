resource "openstack_compute_instance_v2" "k3s_node" {
  name            = "k3s_node"
  image_name      = var.image
  flavor_name     = var.flavor
  key_pair        = var.key_name
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]
  network {
    name = openstack_networking_network_v2.network.name
  }
  user_data = templatefile("templates/install_k3s.tftpl",
    { 
        github_username = var.github_username,
        github_token = var.github_token,
        github_email = var.github_email
    }
  )
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = "public"
}

data "openstack_networking_port_v2" "vm-port" {
  device_id = openstack_compute_instance_v2.k3s_node.id
  network_id = openstack_compute_instance_v2.k3s_node.network[0].uuid
}

resource "openstack_networking_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.floatip_1.address
  port_id = data.openstack_networking_port_v2.vm-port.id
}