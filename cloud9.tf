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

########################################################################
# EC2 for Cloud9（Cloud9では自動でEC2が立ち上がるためimport用コード）
########################################################################
resource "aws_instance" "cloud9" {
  ami           = "ami-01a07b864ab0dd077"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.automation_sg_for_cloud9.id,
    aws_security_group.management_sg.id,
  ]

  tags = {
    Name = "aws-cloud9-sbcntr-dev-16239254061e4c2c821fd158a65ad376"
  }

  lifecycle {
    ignore_changes = [
      user_data,
      user_data_replace_on_change,
    ]
  }
}

resource "aws_security_group" "automation_sg_for_cloud9" {
  name        = "aws-cloud9-sbcntr-dev-16239254061e4c2c821fd158a65ad376-InstanceSecurityGroup-YQ3MNI58UUDV"
  description = "Security group for AWS Cloud9 environment aws-cloud9-sbcntr-dev-16239254061e4c2c821fd158a65ad376"
  vpc_id      = aws_vpc.sbcntr_vpc.id

  tags = {
    Name = "aws-cloud9-sbcntr-dev-16239254061e4c2c821fd158a65ad376"
  }
}

resource "aws_security_group_rule" "automation_sg_for_cloud9_ingress" {
  type      = "ingress"
  to_port   = 22
  from_port = 22
  protocol  = "tcp"
  cidr_blocks = [
    "18.179.48.96/27",
    "18.179.48.128/27",
  ]
  security_group_id = aws_security_group.automation_sg_for_cloud9.id
}

resource "aws_security_group_rule" "automation_sg_for_cloud9_egress" {
  type              = "egress"
  to_port           = 0
  from_port         = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.automation_sg_for_cloud9.id

}

############################################
# IAM for Cloud9
############################################
