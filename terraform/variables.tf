variable "aws_region" {
  type        = string
  description = "The AWS region where resources will be created."
  default     = "us-east-1"
}

variable "namespace" {
  type        = string
  description = "Used in ensuring unique names for resources. For example, an abbreviation for your project."
}

variable "environment" {
  type        = string
  description = "The environment in which the infrastructure is being deployed."
  default     = "dev"
}

variable "name" {
  type        = string
  description = "The name of the service being deployed."
}

variable "artifact_version" {
  type        = string
  description = "The version of the application artifact to deploy."
  default     = ""
}

variable "beanstalk_ec2_role_name" {
  type        = string
  description = "The name of the IAM role used by Elastic Beanstalk EC2 instances."
  default     = "aws-elasticbeanstalk-ec2-role"
}

variable "beanstalk_service_role_name" {
  type        = string
  description = "The name of the IAM role used by Elastic Beanstalk service."
  default     = "aws-elasticbeanstalk-service-role"
}

variable "artifact_bucket_name" {
  type        = string
  description = "The name of the S3 bucket used to store application artifacts."
}
