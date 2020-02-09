resource "aws_alb" "my-alb" {
  name            = "my-alb"
  subnets         = [aws_subnet.us-east-1a-public.id, aws_subnet.us-east-1a-public2.id]
  security_groups = [aws_security_group.alb.id]
  tags = {
    Name = "my-alb"
  }

}

