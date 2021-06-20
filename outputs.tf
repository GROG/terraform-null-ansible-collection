###############################################################################

output "collections_path" {
  value = local.collections_path

  description = <<EOF
Ansible collections path

Path where the collection and it's dependencies are installed.
EOF
}

output "id" {
  value = null_resource.collection.id

  description = <<EOF
Resource ID

This can be used to trigger updates for other resources.
EOF

}

###############################################################################
