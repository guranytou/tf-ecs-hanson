####################################################
# ECR
####################################################

resource "aws_ecr_repository" "backend" {
  name = "sbcntr-backend"

}