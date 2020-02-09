
resource "aws_instance" "webvm" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1a"
    instance_type = "t2.small"
    key_name = aws_key_pair.smartpr.key_name 
    vpc_security_group_ids = ["${aws_security_group.websc.id}"]
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false
    tags = {
        Name = "Web Server 1"
    }
}

resource "aws_instance" "dbvm" {
    ami = "${lookup(var.amis, var.aws_region)}"
    availability_zone = "us-east-1a"
    instance_type = "t2.small"
    key_name = aws_key_pair.smartpr.key_name 
    vpc_security_group_ids = ["${aws_security_group.websc.id}"]
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    associate_public_ip_address = true
    source_dest_check = false
    tags =  {
        Name = "DB Server 1"
    }
}
