variable "username" {
    type        = string
    description = "Username to connect to Openstack instance"
}

variable "password" {
    type        = string
    description = "Password to connect to Openstack instance"
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

// myblog github token related

variable "github_username" {
    type        = string
    description = "Username of the github user"
}

variable "github_token" {
    type        = string
    description = "Token of the github user"
}

variable "github_email" {
    type        = string
    description = "Email of the github user"
}

