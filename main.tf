###############################################################################

locals {
  # SHA1 of the collection name/source
  collection_sha1 = sha1(var.name)

  # Use customized collections path to avoid conflicting version issues
  collections_paths = "${abspath(path.root)}/.ansible/collections/${local.collection_sha1}"

  # Installation commmand
  install_command = "ansible-galaxy collection install -p ${local.collections_paths} ${var.name}"
}

###############################################################################

# Will detect if the module dir has been deleted between runs
resource "local_file" "install_trigger" {
  filename = "${local.collections_paths}/.install_trigger"
  content  = local.install_command
}

# Depends on the install trigger so we re-run when the folder no longer exists
resource "null_resource" "collection" {
  triggers = {
    install_trigger = local_file.install_trigger.id
  }
  provisioner "local-exec" {
    command = local.install_command
  }
}

###############################################################################
