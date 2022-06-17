resource "aws_cloud9_environment_ec2" "management" {
  instance_type               = "t2.micro"
  name                        = "sbcntr-dev"
  subnet_id = aws_subnet.sbcntr_subnet_pub_manage_1a.id
}

