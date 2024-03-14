locals {
  resource_prefix = "${var.namespace}-${var.environment}-${var.name}"

  common_tags = {
    Namespace       = "${var.namespace}"
    Environment     = "${var.environment}"
    ApplicationName = "${var.name}"
    ManagedBy       = "Terraform"
  }
}
