resource "aws_security_group" "bia_dev_tf" {
  name        = "bia-dev-ec2-tf"
  description = "Acesso da maquina de trabalho"
  vpc_id      = local.vpc_id

  ingress {
    description      = "Liberado para todos"
    from_port        = 3001
    to_port          = 3001
    protocol         = "tcp"
    cidr_blocks      = [ "0.0.0.0/0" ]
  }

  ingress {
    description = "Acesso SSH para IP especifico"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [ "170.238.53.230/32" ] 
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # todos os trafegos(all trafic)
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bia-dev-ec2-tf"
    CreatedBy = local.terraform
  }
}


resource "aws_security_group" "bia_ec2_tf" {
  description = "Acesso do bia ec2"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = []
    description      = "Liberado para ALB"
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = [ aws_security_group.bia_alb_tf.id ]
    self             = false
    to_port          = 65535
  }]
  name                   = "bia-ec2-tf"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags = {
    Name = "bia-ec2-tf"
    CreatedBy = local.terraform
  }
  tags_all = {
    Name = "bia-ec2-tf"
    CreatedBy = local.terraform
  }
  vpc_id = local.vpc_id
}


resource "aws_security_group" "bia_web_tf" {
  description = "Acesso do bia web"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]
  name                   = "bia-web"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags = {
    Name = "bia-web-tf"
    CreatedBy = local.terraform
  }
  tags_all = {
    Name = "bia-web-tf"
    CreatedBy = local.terraform
  }
  vpc_id = local.vpc_id
}

resource "aws_security_group" "bia_alb_tf" {
  description = "Acesso do bia-alb"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Liberado para todos"
    from_port        = 443
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 443
    }, {
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "Liberado para todos"
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
  }]
  name                   = "bia-alb-tf"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags = {
    Name = "bia-alb-tf"
    CreatedBy = local.terraform
  }
  tags_all = {
    Name = "bia-alb-tf"
    CreatedBy = local.terraform
  }
  vpc_id = local.vpc_id
}


resource "aws_security_group" "bid_db_tf" {
  description = "Acesso do bia db"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [
    {
      cidr_blocks      = []
      description      = "Liberado para bia dev"
      from_port        = 5432
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = [ aws_security_group.bia_dev_tf.id ]
      self             = false
      to_port          = 5432
    },
    {
      cidr_blocks      = []
      description      = "Liberado para bia ec2"
      from_port        = 5432
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = [ aws_security_group.bia_ec2_tf.id ]
      self             = false
      to_port          = 5432
    },
    {
      cidr_blocks      = []
      description      = "Liberado parab ia web"
      from_port        = 5432
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = [ aws_security_group.bia_web_tf.id ]
      self             = false
      to_port          = 5432
      }
  ]
  name                   = "bia-db-tf"
  name_prefix            = null
  revoke_rules_on_delete = null
  tags = {
    Name = "bia-db-tf"
    CreatedBy = local.terraform
  }
  tags_all = {
    Name = "bia-db-tf"
    CreatedBy = local.terraform
  }
  vpc_id = local.vpc_id
}
