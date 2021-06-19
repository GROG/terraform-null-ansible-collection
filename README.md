# terraform-null-ansible-collection

[![Latest tag][tag_image]][tag_url]
[![Gitter chat][gitter_image]][gitter_url]

A Terraform module for installing Ansible collections.

It uses a hash of the collection source to install the collection and it's
dependencies in an isolated folder. Allowing you to easily combine different
versions for different parts of the infrastructure.

It provides an output that can be used to pass the custom collections path to
Ansible

## Usage

```hcl
# Installing a collection from galaxy
module "mynamespace_mycollection_example1" {
  source = "GROG/ansible-collection/null"
  name   = "my_namespace.my_collection"
}

# Adding version info (recommended)
module "mynamespace_mycollection_example2" {
  source = "GROG/ansible-collection/null"
  name   = "my_namespace.my_collection:>=1.0.0,<2.0.0"
}

# You can also use git urls or local files
module "my_collection" {
  source = "GROG/ansible-collection/null"
  name   = "https://github.com/my/ansible-collection"
}

# Some other resource using the collections path
resource "null_resource" "run_ansible" {
  provisioner "local-exec" {
    command = "ANSIBLE_COLLECTIONS_PATHS=${module.my_collection.collections_paths} ansible-playbook my_collection.playbook"
  }
}

```

## Requirements

- ansible-core-2.11.0 +

## Inputs

| Variable | Description | Type | Default value |
|----------|-------------|------|---------------|
| `name` | Name or source of the collection to install, can include version info | `string` | / |

## Outputs

| Variable | Description | Type |
|----------|-------------|------|
| `id` | Resource ID | `string` |

## Contributing

All assistance, changes or ideas [welcome][issues]!

## Author

By [G. Roggemans][groggemans]

## License

MIT

[tag_image]:    https://img.shields.io/github/tag/GROG/terraform-null-ansible-collection.svg
[tag_url]:      https://github.com/GROG/terraform-null-ansible-collection
[gitter_image]: https://badges.gitter.im/GROG/chat.svg
[gitter_url]:   https://gitter.im/GROG/chat

[issues]:       https://github.com/GROG/terraform-null-ansible-collection
[groggemans]:   https://github.com/groggemans
