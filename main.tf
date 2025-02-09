/* resource "aws_key_pair" "pub_kp" {
  key_name   = "pub_kp"
  public_key = file("${path.module}/id_rsa.pub")

} */
resource "aws_security_group" "tf_sg" {
  name        = "tf_sg"
  description = "sg created by terraform"
  dynamic "ingress" {
    for_each = [22, 80, 443]
    iterator = port
    content {
      description = "allow ports"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

}

resource "aws_instance" "web" {
  ami                    = var.ami
  instance_type          = var.instance_type
  # key_name               = aws_key_pair.pub_kp.key_name
  vpc_security_group_ids = [aws_security_group.tf_sg.id]
  tags = {
    Name = "tf_instance"
  }

}

output "ami_id" {
  value = aws_instance.web.ami

}
output "sg_id" {
  value = aws_security_group.tf_sg.id

}
output "ec2-ip" {
  value = aws_instance.web.public_ip

}