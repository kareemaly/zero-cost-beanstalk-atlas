resource "aws_elastic_beanstalk_application" "main" {
  name        = "${local.resource_prefix}-app"
  description = "Elastic Beanstalk Application"

  tags = local.common_tags
}

resource "aws_elastic_beanstalk_application_version" "main" {
  count = var.artifact_version != "" ? 1 : 0

  name        = var.artifact_version
  application = aws_elastic_beanstalk_application.main.name
  description = "Version ${var.artifact_version} of the planner-api application"
  bucket      = aws_s3_bucket.artifact.bucket
  key         = "${var.artifact_version}.zip"

  tags = local.common_tags
}

resource "aws_elastic_beanstalk_environment" "main" {
  count = var.artifact_version != "" ? 1 : 0

  name                = "${local.resource_prefix}-app-env"
  application         = aws_elastic_beanstalk_application.main.name
  solution_stack_name = "64bit Amazon Linux 2023 v6.1.1 running Node.js 20"
  tier                = "WebServer"
  version_label       = aws_elastic_beanstalk_application_version.main.name

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = data.aws_iam_instance_profile.beanstalk_ec2.name
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "ServiceRole"
    value     = data.aws_iam_role.beanstalk_service.arn
  }

  setting {
    namespace = "aws:ec2:instances"
    name      = "InstanceTypes"
    value     = "t2.micro"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application"
    name      = "Application Healthcheck URL"
    value     = "/health"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "NODE_ENV"
    value     = "production"
  }

  tags = local.common_tags
}
