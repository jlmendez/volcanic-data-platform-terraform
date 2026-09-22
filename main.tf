terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
    }
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