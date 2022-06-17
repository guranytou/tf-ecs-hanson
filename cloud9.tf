############################################
# Cloud9
############################################
resource "aws_cloud9_environment_ec2" "management" {
  instance_type               = "t2.micro"
  name                        = "sbcntr-dev"
  automatic_stop_time_minutes = 30
  subnet_id                   = aws_subnet.sbcntr_subnet_pub_manage_1a.id
  image_id                    = "amazonlinux-2-x86_64"
}

############################################
# EC2 for Cloud9
############################################
# resource "aws_instance" "cloud9" {
#   ami = "ami-011cfcf7a08034ef3"
#   instance_type = "t2.micro"
# }

############################################
# IAM for Cloud9
############################################
