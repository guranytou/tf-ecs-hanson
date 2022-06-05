module "ingress_sg" {
  source = "./modules/security_group"

  name        = "ingress_sg"
  vpc_id      = aws_vpc.sbcntr_vpc.id
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

module "front_app_sg" {
  source = "./modules/security_group"

  name = "front_app_sg"
  vpc_id = aws_vpc.sbcntr_vpc.id
  from_port = 80
  to_port = 80
  protocol = "tcp"
  source_security_group_id = module.ingress_sg.security_group_id
}

# module "internal_alb_sg" {
#   source = "./modules/security_group"

#   name = "front_app_sg"
#   vpc_id = aws_vpc.sbcntr_vpc.id
#   from_port = 80
#   to_port = 80
#   protocol = "tcp"
#   source_security_group_id = module.ingress_sg.security_group_id
# }