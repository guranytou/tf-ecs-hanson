####################################################
# ECR
####################################################

resource "aws_ecr_repository" "backend" {
  name = "sbcntr-backend"
  encryption_configuration {
    encryption_type = "KMS"
  }
}

resource "aws_ecr_repository" "frontenc" {
  name = "sbcntr-frontend"
  encryption_configuration {
    encryption_type = "KMS"
  }
}

####################################################
# IAM Role
####################################################

resource "aws_iam_role" "ecs_deploy" {
  name               = "ecsCodeDeployRole"
  assume_role_policy = data.aws_iam_policy_document.ecs_deploy_assume_role_policy.json
}
data "aws_iam_policy_document" "ecs_deploy_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }
  }
}

data "aws_iam_policy" "ecs_deploy" {
  name = "AWSCodeDeployRoleForECS"
}

resource "aws_iam_role_policy_attachment" "ecs_deploy" {
  role       = aws_iam_role.ecs_deploy.name
  policy_arn = data.aws_iam_policy.ecs_deploy.arn
}