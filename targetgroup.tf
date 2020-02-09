
resource "aws_alb_target_group" "frontend-target-group" {
  name = "alb-target-group"
  port = 80
  protocol = "HTTP"
  vpc_id = "${aws_vpc.main_vpc.id}"
}



resource "aws_alb_target_group_attachment" "frontend-attachment-1" {
  target_group_arn = "${aws_alb_target_group.frontend-target-group.arn}"
  target_id = "${aws_instance.webvm.id}"
  port = 80
}

resource "aws_alb_listener" "frontend-listeners" {
  load_balancer_arn = "${aws_alb.my-alb.arn}"
  port = "80"

  default_action {
    target_group_arn = "${aws_alb_target_group.frontend-target-group.arn}"
    type = "forward"
  }
}
