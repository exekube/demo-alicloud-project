# ↓ Module metadata

terragrunt = {
  terraform {
    source = "/exekube-modules//ali-cluster"
  }

  include = {
    path = "${find_in_parent_folders()}"
  }
}

# ↓ Module configuration (empty means all default)

ssh_password = "/project/live/dev/secrets/kube-system/alicloud/ssh-password"

vswitch_id = "INSERT_FROM_NETWORK_MODULE_OUTPUT"
