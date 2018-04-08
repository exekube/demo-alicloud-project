terragrunt = {
  # Configure Terragrunt to automatically store tfstate files in an GCS bucket
  remote_state {
    backend = "gcs"

    config {
      bucket      = "${get_env("TFSTATE_BUCKET", "")}"
      credentials = "${get_env("TFSTATE_BUCKET_KEY", "")}"
      prefix      = "${path_relative_to_include()}"
    }
  }

  terraform {
    extra_arguments "auto_approve" {
      commands  = ["apply"]
      arguments = ["-auto-approve"]
    }

    extra_arguments "force_destroy" {
      commands  = ["destroy"]
      arguments = ["-force"]
    }
  }
}
