provider "aws" {
  region  = "us-east-1"
  profile = "terraform_aws"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "key_name" {
  description = "The name of the EC2 key pair to use for SSH access"
  type        = string
  default     = "jiturana"
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = data.aws_vpc.default.id

  tags = {
    Name = "Security_allow_tls"
  }
}

# Ingress Rules - IPv4
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_443" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_3000" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = 3000
  to_port           = 3000
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_3001" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = 3001
  to_port           = 3001
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4_8090" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = data.aws_vpc.default.cidr_block
  from_port         = 8090
  to_port           = 8090
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
}

# Ingress Rule - IPv6
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# Egress Rules
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1"
}

# EC2 Instance
resource "aws_instance" "my_first_server" {
  count                     = 1
  ami                       = data.aws_ami.ubuntu.id
  instance_type             = "t2.medium"
  key_name                  = var.key_name
  vpc_security_group_ids    = [aws_security_group.allow_tls.id]

  tags = {
    Name = "terraform ubuntu - ${count.index + 1}"
  }
}
