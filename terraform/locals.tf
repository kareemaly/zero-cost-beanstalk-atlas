locals {
  resource_prefix = "${var.namespace}-${var.name}"

  common_tags = {
    Namespace       = "${var.namespace}"
    ApplicationName = "${var.name}"
    ManagedBy       = "Terraform"
  }
}
