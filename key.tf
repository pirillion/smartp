resource "aws_key_pair" "smartpr" {
  key_name   = "smartpr"
  public_key = file("/root/.ssh/mykey.pub")
}

