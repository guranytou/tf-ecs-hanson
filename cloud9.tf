resource "aws_cloud9_environment_ec2" "management" {
  instance_type               = "t2.micro"
  name                        = "sbcntr-dev"
  image_id                    = "amazonlinux-2-x86_64"
  automatic_stop_time_minutes = 30
  subnet_id                   = aws_subnet.sbcntr_subnet_pub_manage_1a.id
  connection_type             = "CONNECT_SSH"
}

