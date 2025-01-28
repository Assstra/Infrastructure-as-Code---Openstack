variable "username" {
    type        = string
    description = "Username to connect to Openstack instance"
}

variable "password" {
    type        = string
    description = "Password to connect to Openstack instance"
}

variable "name" {
    type        = string
    description = "Name of the instance"
}

variable "key_name" {
    type        = string
    description = "Name of an existing key pair to use for the server"
}

variable "flavor" {
    type        = string
    description = "Flavor for the server to be created"
    default     = "m1.small"
}

variable "image" {
    type        = string
    description = "Image ID or image name to use for the server"
}

variable "net" {
    type    = string
    default = "ar-network"
}
