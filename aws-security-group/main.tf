
resource "aws_security_group" "private-web-server" {
  name        = "private-web-server-ssr"
  description = "Allow inbound traffic for private web servers"
  vpc_id      = "vpc-0d2831659ef89870c"
  ingress {
    description = "Allow ssh from bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.1.0.0/21"]
  }
  ingress {
    description = "Allow ssh from bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.1.8.0/21"]
  }
  ingress {
    description = "Allow TCP from users"
    from_port   = 3030
    to_port     = 3030
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = var.private_web_server_name
    responsible = var.instance_project,
    project = var.instance_responsile
  }
}

resource "aws_security_group" "bastion-sg" {
  name        = "bastion-sg"
  description = "Allow SSH traffic from client"
  vpc_id      = "vpc-0d2831659ef89870c"
  ingress {
    description      = "Allow ssh from bastion"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = var.bastion_sg,
    responsible = var.instance_project,
    project = var.instance_responsile
  }
}


resource "aws_security_group" "load-balancer-sg" {
  name        = "load-balancer-sg"
  description = "Allow traffic from client"
  vpc_id      = "vpc-0d2831659ef89870c"
  ingress {
    description = "Allow TCP 3030 from clients"
    from_port   = 3030
    to_port     = 3030
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow TCP 3000 from clients"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow HTTP connection from clients"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = var.load_balancer_sg,
    responsible = var.instance_project,
    project = var.instance_responsile
  }
}

resource "aws_security_group" "data-base-sg" {
  name        = "data-base-sg"
  description = "Access database from servers"
  vpc_id      = "vpc-0d2831659ef89870c"
  ingress {
    description = "Allow TCP connection from private subnet 0"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.1.80.0/21"]
  }
  ingress {
    description = "Allow TCP 3000 from clients"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.1.88.0/21"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name        = var.data_base_sg,
    responsible = var.instance_project,
    project = var.instance_responsile
  }
}

