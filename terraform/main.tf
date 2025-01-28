resource "openstack_compute_instance_v2" "nginx_load_balancer" {
  name            = "nginx_load_balancer"
  image_name      = "Debian-12"
  flavor_name     = "m1.small"
  key_pair        = "ar"
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]
  network {
    name = openstack_networking_network_v2.network.name
  }
  user_data = templatefile("templates/nginx.tftpl", { front1_ip = openstack_compute_instance_v2.aggregator1.network[0].fixed_ip_v4 , front2_ip = openstack_compute_instance_v2.aggregator2.network[0].fixed_ip_v4 })
}

resource "openstack_compute_instance_v2" "aggregator1" {
  name            = "aggregator1"
  image_name      = "Debian-12"
  flavor_name     = "m1.small"
  key_pair        = "ar"
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]

  network {
    name = openstack_networking_network_v2.network.name
  }
  user_data = templatefile("templates/simple-app-service.tftpl", { playbook_name = "aggregator" , app_port = "3000" , noun_provider_ip = openstack_compute_instance_v2.noun.network[0].fixed_ip_v4 , verb_provider_ip = openstack_compute_instance_v2.verb.network[0].fixed_ip_v4 })
}

resource "openstack_compute_instance_v2" "aggregator2" {
  name            = "aggregator2"
  image_name      = "Debian-12"
  flavor_name     = "m1.small"
  key_pair        = "ar"
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]

  network {
    name = openstack_networking_network_v2.network.name
  }
  user_data = templatefile("templates/simple-app-service.tftpl", { playbook_name = "aggregator" , app_port = "3000" , noun_provider_ip = openstack_compute_instance_v2.noun.network[0].fixed_ip_v4 , verb_provider_ip = openstack_compute_instance_v2.verb.network[0].fixed_ip_v4 })
}

resource "openstack_compute_instance_v2" "noun" {
  name            = "noun"
  image_name      = "Debian-12"
  flavor_name     = "m1.small"
  key_pair        = "ar"
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]

  network {
    name = openstack_networking_network_v2.network.name
  }
  user_data = templatefile("templates/simple-app-service.tftpl", { playbook_name = "noun" , app_port = "3000" , noun_provider_ip = "" , verb_provider_ip = "" })
}

resource "openstack_compute_instance_v2" "verb" {
  name            = "verb"
  image_name      = "Debian-12"
  flavor_name     = "m1.small"
  key_pair        = "ar"
  security_groups = [openstack_networking_secgroup_v2.secgroup.name]

  network {
    name = openstack_networking_network_v2.network.name
  }
  user_data = templatefile("templates/simple-app-service.tftpl", { playbook_name = "verb" , app_port = "3000" , noun_provider_ip = "" , verb_provider_ip = "" })
}

resource "openstack_networking_floatingip_v2" "floatip_1" {
  pool = "public"
}

data "openstack_networking_port_v2" "vm-port" {
  device_id = openstack_compute_instance_v2.nginx_load_balancer.id
  network_id = openstack_compute_instance_v2.nginx_load_balancer.network[0].uuid
}

resource "openstack_networking_floatingip_associate_v2" "fip_1" {
  floating_ip = openstack_networking_floatingip_v2.floatip_1.address
  port_id = data.openstack_networking_port_v2.vm-port.id
}

