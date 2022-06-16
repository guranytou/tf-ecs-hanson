############################################
# SG(external-alb)
############################################
resource "aws_security_group" "external_alb_sg" {
  name   = "ingress_sg"
  vpc_id = aws_vpc.sbcntr_vpc.id
}

resource "aws_security_group_rule" "external_alb_sg_ingress" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.external_alb_sg.id
}

resource "aws_security_group_rule" "external_alb_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.external_alb_sg.id
}

############################################
# SG(front-app)
############################################
resource "aws_security_group" "front_app_sg" {
  name   = "front_app_sg"
  vpc_id = aws_vpc.sbcntr_vpc.id
}

resource "aws_security_group_rule" "front_app_sg_ingress" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.external_alb_sg.id
  security_group_id        = aws_security_group.front_app_sg.id
}

resource "aws_security_group_rule" "front_app_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.front_app_sg.id
}

############################################
# SG(internal-alb)
############################################
resource "aws_security_group" "internal_alb_sg" {
  name   = "internal_alb_sg"
  vpc_id = aws_vpc.sbcntr_vpc.id
}

resource "aws_security_group_rule" "internal_alb_sg_ingress_for_front_app" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.front_app_sg.id
  security_group_id        = aws_security_group.internal_alb_sg.id
}

resource "aws_security_group_rule" "internal_alb_sg_ingress_for_management_sub" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.management_sg.id
  security_group_id        = aws_security_group.internal_alb_sg.id
}

resource "aws_security_group_rule" "internal_alb_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.internal_alb_sg.id
}

############################################
# SG(backend-app)
############################################
resource "aws_security_group" "backend_app_sg" {
  name   = "backend_app_sg"
  vpc_id = aws_vpc.sbcntr_vpc.id
}

resource "aws_security_group_rule" "backend_app_sg_ingress" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.internal_alb_sg.id
  security_group_id        = aws_security_group.backend_app_sg.id
}

resource "aws_security_group_rule" "backend_app_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.backend_app_sg.id
}

############################################
# SG(db)
############################################
resource "aws_security_group" "db_sg" {
  name   = "front_app_sg"
  vpc_id = aws_vpc.sbcntr_vpc.id
}

resource "aws_security_group_rule" "db_sg_ingress_for_app" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.backend_app_sg.id
  security_group_id        = aws_security_group.db_sg.id
}

resource "aws_security_group_rule" "db_sg_ingress_for_management" {
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.management_sg.id
  security_group_id        = aws_security_group.db_sg.id
}

resource "aws_security_group_rule" "db_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.backend_app_sg.id
}

############################################
# SG(management)
############################################
resource "aws_security_group" "management_sg" {
  name   = "management_sg"
  vpc_id = aws_vpc.sbcntr_vpc.id
}

resource "aws_security_group_rule" "management_sg_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.management_sg.id
}