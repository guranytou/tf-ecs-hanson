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