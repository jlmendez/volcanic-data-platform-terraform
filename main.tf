terraform {
  required_providers {
    databricks = {
      source = "databricks/databricks"
    }
  }

  backend "s3" {
    bucket       = "volcanic-terraform-state-1b3d5f-471112658477-us-east-2-an"
    key          = "volcanic-data-platform/terraform.tfstate"
    region       = "us-east-2"
    use_lockfile = true
    encrypt      = true
  }
}

provider "databricks" {
  profile = "VOLCANIC"
}

data "databricks_current_user" "me" {}

output "current_user" {
  value = data.databricks_current_user.me.user_name
}

resource "databricks_notebook" "terraform_demo" {
  path = "${data.databricks_current_user.me.home}/Terraform_Volcanic_Demo"

  language = "PYTHON"

  source = "${path.module}/notebooks/volcanic_demo.py"
}