resource "aws_security_group" "kpmgchallenge-ext-alb-sg" {
  vpc_id = var.vpc_id
  name = format("kpmgchallenge-%s-%s-alb-sg", var.account_environment, var.kpmgchallenge_region)
  description = "kpmgchallenge Public facing LB Security Group"
  tags = {
    Name = format("kpmgchallenge-%s-%s-alb-sg", var.account_environment, var.kpmgchallenge_region)
  }
}

resource "aws_security_group_rule" "kpmgchallenge-sg-ext-in80-01" {
  type = "ingress"
  from_port = 80
  to_port = 80
  protocol = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.kpmgchallenge-ext-alb-sg.id
  description = "Accept traffic on 80 that redirects to 443"
}

resource "aws_security_group_rule" "kpmgchallenge-sg-ext-in443-01" {
  type = "ingress"
  from_port = 443
  to_port = 443
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.kpmgchallenge-ext-alb-sg.id
  description = "Public Access"
}

resource "aws_security_group_rule" "kpmgchallenge-sg-ext-eg" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  security_group_id = aws_security_group.kpmgchallenge-ext-alb-sg.id
}

resource "aws_alb" "kpmgchallenge-ext-alb" {
  name = format("kpmgchallenge-%s-%s-alb", var.account_environment, var.kpmgchallenge_region)
  internal = false
  load_balancer_type = "application"
  subnets = var.public_subnets
  security_groups = [aws_security_group.kpmgchallenge-ext-alb-sg.id]
  enable_cross_zone_load_balancing = true
  enable_deletion_protection = true
  tags = {
    Name = format("kpmgchallenge-%s-%s-alb", var.account_environment, var.kpmgchallenge_region)
  }
}

resource "aws_alb_listener" "kpmgchallenge-ext-alb-listener-80" {
  load_balancer_arn = aws_alb.kpmgchallenge-ext-alb.arn
  port = "80"
  protocol = "HTTP"
  default_action {
    type = "redirect"
    redirect {
      status_code = "HTTP_301"
      protocol = "HTTPS"
      port = "443"
    }
  }
}

resource "aws_alb_listener" "kpmgchallenge-ext-alb-listener-443" {
  load_balancer_arn = aws_alb.kpmgchallenge-ext-alb.arn
  port = "443"
  protocol = "HTTPS"
  default_action {
    type = "fixed-response"
    fixed_response {
      content_type = "text/html"
      message_body = "<html><head><title>404 Not Found</title></head><body><center><h1>404 Not Found</h1></center><hr><center>nginx</center></body></html>"
      status_code = "404"
    }
  }
}

resource "aws_alb_target_group" "kpmgchallenge-backend-service-tg" {
  name     = format("kpmgchallenge-%s-%s-backend-service", var.account_environment, var.kpmgchallenge_region)
  port     = 8090
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  health_check {
    path = "/actuator/health"
    matcher = "200"
  }
  tags = {
    Name = format("kpmgchallenge-%s-%s-backend-service", var.account_environment, var.kpmgchallenge_region)
  }
}


#User management Service Rules
resource "aws_lb_listener_rule" "kpmgchallenge-backend-service1" {
  listener_arn = aws_alb_listener.kpmgchallenge-ext-alb-listener-443.arn
  priority     = 13
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.kpmgchallenge-backend-service-tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/backend-service/*"]
    }
  }
}

resource "aws_lb_listener_rule" "kpmgchallenge-backend-service2" {
  listener_arn = aws_alb_listener.kpmgchallenge-ext-alb-listener-443.arn
  priority     = 14
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.kpmgchallenge-backend-service-tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/v1/backend-service"]
    }
  }
}

resource "aws_lb_listener_rule" "kpmgchallenge-backend-service3" {
  listener_arn = aws_alb_listener.kpmgchallenge-ext-alb-listener-443.arn
  priority     = 15
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.kpmgchallenge-backend-service-tg.arn
  }

  condition {
    path_pattern {
      values = ["/api/v1/login"]
    }
  }
}

resource "aws_alb_target_group" "kpmgchallenge-frontend-service-tg" {
  name     = format("kpmgchallenge-%s-%s-frontend-service", var.account_environment, var.kpmgchallenge_region)
  port     = 3000
  protocol = "HTTP"
  target_type = "ip"
  vpc_id   = var.vpc_id

  health_check {
    path = "/actuator/health"
    matcher = "200"
  }
  tags = {
    Name = format("kpmgchallenge-%s-%s-frontend-service", var.account_environment, var.kpmgchallenge_region)
  }
}

resource "aws_lb_listener_rule" "kpmgchallenge-frontend-service3" {
  listener_arn = aws_alb_listener.kpmgchallenge-ext-alb-listener-443.arn
  priority     = 15
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.kpmgchallenge-frontend-service-tg.arn
  }

  condition {
    path_pattern {
      values = ["/"]
    }
  }
}
