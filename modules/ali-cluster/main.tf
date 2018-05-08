variable "access_key" {}
variable "secret_key" {}
variable "ssh_password" {}
variable "vswitch_id" {}

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

module "ali_cluster" {
  source = "/exekube-modules/ali-cluster"

  ssh_password = "${var.ssh_password}"
  vswitch_id   = "${var.vswitch_id}"
}
