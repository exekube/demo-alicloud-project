# ------------------------------------------------------------------------------
# INPUT VARIABLES
# ------------------------------------------------------------------------------

variable "access_key" {}
variable "secret_key" {}

variable "dns_zones" {
  default = []
}

# ------------------------------------------------------------------------------
# TERRAFORM AND PROVIDER CONFIG
# ------------------------------------------------------------------------------

terraform {
  backend "gcs" {}
}

provider "alicloud" {
  version    = ">= 1.9.1"
  region     = "cn-beijing"
  access_key = "${chomp(file("${var.access_key}"))}"
  secret_key = "${chomp(file("${var.secret_key}"))}"
}

# ------------------------------------------------------------------------------
# RESOURCES AND EXTERNAL MODULE IMPORTS
# ------------------------------------------------------------------------------

module "ali_network" {
  source = "/exekube-modules/ali-network"

  create_eip = false

  dns_zones = "${var.dns_zones}"
}

# ------------------------------------------------------------------------------
# OUTPUTS
# ------------------------------------------------------------------------------


/*
output "static_ip_address" {
  value = "${module.gke_network.static_ip_address}"
}

output "dns_zones" {
  value = "${module.gke_network.dns_zones}"
}

output "dns_zone_servers" {
  value = "${module.gke_network.dns_zone_servers}"
}
*/

