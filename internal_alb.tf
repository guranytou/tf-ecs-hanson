####################################################
# ALB/internal
####################################################

resource "aws_lb" "internal_alb" {
  name               = "sbcntr-alb-internal"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.internal_alb_sg.id]
  subnets = [
    aws_subnet.sbcntr_subnet_pri_container_1a.id,
    aws_subnet.sbcntr_subnet_pri_container_1c.id,
  ]
}

resource "aws_lb_listener" "internal_alb_listener_blue" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_alb_tg_blue.arn
  }
}

resource "aws_lb_target_group" "internal_alb_tg_blue" {
  name        = "sbcntr-tg-sbcntrdemo-blue"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.sbcntr_vpc.id

  health_check {
    path                = "/healthcheck"
    interval            = 15
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = 200
  }
}

resource "aws_lb_listener" "internal_alb_listener_green" {
  load_balancer_arn = aws_lb.internal_alb.arn
  port              = 10080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.internal_alb_tg_green.arn
  }
}

resource "aws_lb_target_group" "internal_alb_tg_green" {
  name        = "sbcntr-tg-sbcntrdemo-green"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_vpc.sbcntr_vpc.id

  health_check {
    path                = "/healthcheck"
    interval            = 15
    healthy_threshold   = 3
    unhealthy_threshold = 2
    timeout             = 5
    matcher             = 200
  }
}

