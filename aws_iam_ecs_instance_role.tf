data "aws_iam_policy_document" "fmctf_ecs_instance_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "fmctf_ecs_instance_role" {
  #name_prefix        = "fmctf-ecs-instance-role"
  name               = "fmctf-ecs-instance-role"
  assume_role_policy = data.aws_iam_policy_document.fmctf_ecs_instance_role.json
  description        = "Permite instancias EC2 chamar servicos da AWS em seu nome."
  tags               = { CreatedBy = local.terraform }
}

resource "aws_iam_role_policy_attachment" "fmctf_ecs_instance_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role" #permite baixar imagem do ECR
  role       = aws_iam_role.fmctf_ecs_instance_role.name
}

resource "aws_iam_role_policy_attachment" "fmctf_ssm_managed_instance_core" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore" #permite conexão com ssm
  role       = aws_iam_role.fmctf_ecs_instance_role.name
}

resource "aws_iam_instance_profile" "fmctf_ecs_node" {
  name_prefix = "fmctf-ecs-instance-role-profile"
  path        = "/ecs/instance/"
  role        = aws_iam_role.fmctf_ecs_instance_role.name
  tags        = { CreatedBy = local.terraform }
  tags_all    = { CreatedBy = local.terraform }
}