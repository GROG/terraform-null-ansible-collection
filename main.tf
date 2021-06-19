###############################################################################

locals {
  # SHA1 of the collection source (which includes the version)
  collection_source_sha1 = sha1(var.source)

  # Use customized collections path to avoid conflicting version issues
  collections_paths = "${abspath(path.root)}/.ansible/collections/${local.collection_source_sha1}"

  # Installation commmand
  install_command = "ansible-galaxy collection install -p ${local.collections_paths} ${var.collection.source}"
}

###############################################################################

# Will detect if the module dir has been deleted between runs
resource "local_file" "install_trigger" {
  path = "${local.collections_paths}/.install_trigger"
  content = install_command
}

# Depends on the install trigger so we re-run when the folder no longer exists
resource "null_resource" "collection" {
  provisioner "local-exec" {
    command = local_file.install_trigger.content
  }
}

###############################################################################
