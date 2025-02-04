resource "aws_launch_template" "lt" {
  name          = "proj-lt"
  instance_type = "t2.micro"
  image_id      = "ami-00bb6a80f01f03502"
  key_name      = "aws_login2"
  # vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  user_data = filebase64("sh.sh")
  network_interfaces {
    associate_public_ip_address = false
    ipv6_address_count          = 0
    security_groups             = [aws_security_group.ec2_sg.id]
  }
}

resource "aws_instance" "host" {
  ami                    = "ami-00bb6a80f01f03502"
  instance_type          = "t2.micro"
  key_name               = "aws_login2"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id              = aws_subnet.public[0].id
  tags = {
    Name = "Host"
  }
}