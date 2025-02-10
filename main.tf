/* resource "aws_key_pair" "pub_kp" {
  key_name   = "pub_kp"
  public_key = file("${path.module}/id_rsa.pub")

} */
resource "aws_security_group" "tf_sg" {
  name        = "tf_sg1"
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

resource "aws_s3_bucket" "S3_bucket" {
  bucket = "my-tf-test-bucket21025"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
resource "aws_iam_role" "test_role" {
  name = "test_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "tag-value"
  }
}

output "s3_arn" {
  value = aws_s3_bucket.S3_bucket.arn

}
output "sg_id" {
  value = aws_security_group.tf_sg.id

}
output "role_arn" {
  value = aws_iam_role.test_role.arn

}
