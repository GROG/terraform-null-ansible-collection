###############################################################################

terraform {
  required_version = ">=1.0"
  required_providers {
    null = {
      source = "hashicorp/null"
    }
    local_file = {
      source = "hashicorp/local_file"
    }
  }
}

###############################################################################

