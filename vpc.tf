resource "aws_vpc" "main_vpc" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "terraform-aws-vpc"
    }
}

resource "aws_eip" "db" {
    instance = "${aws_instance.dbvm.id}"
    vpc = true
}

resource "aws_eip" "web" {
    instance = "${aws_instance.webvm.id}"
    vpc = true
}

resource "aws_route_table" "us-east-1a-public" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.ig-main.id}"
    }

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "us-east-1a-public2" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.ig-main.id}"
    }

    tags = {
        Name = "Public Subnet 2"
    }
}

resource "aws_route_table_association" "us-east-1a-public" {
    subnet_id = "${aws_subnet.us-east-1a-public.id}"
    route_table_id = "${aws_route_table.us-east-1a-public.id}"
}


resource "aws_route_table_association" "us-east-1a-public2" {
    subnet_id = "${aws_subnet.us-east-1a-public2.id}"
    route_table_id = "${aws_route_table.us-east-1a-public2.id}"
}




resource "aws_subnet" "us-east-1a-public" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1a"

    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_subnet" "us-east-1a-public2" {
    vpc_id = "${aws_vpc.main_vpc.id}"

    cidr_block = "${var.public2_subnet_cidr}"
    availability_zone = "us-east-1b"

    tags = {
        Name = "Public Subnet 2"
    }
}

resource "aws_internet_gateway" "ig-main" {
    vpc_id = "${aws_vpc.main_vpc.id}"
}
