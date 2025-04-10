resource "aws_iam_instance_profile" "acesso_ssm_role" {
  name        = "fmctf-acesso-ssm-role"
  name_prefix = null
  path        = "/"
  role        = aws_iam_role.acesso_ssm_role.name
  tags        = { CreatedBy = local.terraform }
  tags_all    = {}
}


resource "aws_iam_role" "acesso_ssm_role" {
  name                  = "fmctf-acesso-ssm-role"
  name_prefix           = null
  path                  = "/"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = "Permite instancias EC2 chamar servicos da AWS em seu nome."
  force_detach_policies = false
  ## deprecated ##
  #managed_policy_arns   = ["arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess", "arn:aws:iam::aws:policy/AmazonECS_FullAccess", "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
  max_session_duration  = 3600
  permissions_boundary  = null
  tags                  = { CreatedBy = local.terraform }
  tags_all              = {}
}

# Anexando políticas gerenciadas ao papel IAM
resource "aws_iam_role_policy_attachment" "ecr_full_access" {
  role       = aws_iam_role.acesso_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_role_policy_attachment" "ecs_full_access" {
  role = aws_iam_role.acesso_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonECS_FullAccess"
}

# Permite acesso via SSM para instâncias de DEV no EC2
resource "aws_iam_role_policy_attachment" "ssm_managed_instance_core" {
  role = aws_iam_role.acesso_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Permite acesso ao cofre do RDS da BIA na instâncias de DEV no EC2
resource "aws_iam_role_policy_attachment" "ec2_get_secret_policy" {
  role       = aws_iam_role.acesso_ssm_role.name
  policy_arn = aws_iam_policy.get_secret_bia_db_policy.arn
}