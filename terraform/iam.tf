data "aws_iam_instance_profile" "beanstalk_ec2" {
  name = var.beanstalk_ec2_role_name
}

data "aws_iam_role" "beanstalk_service" {
  name = var.beanstalk_service_role_name
}
