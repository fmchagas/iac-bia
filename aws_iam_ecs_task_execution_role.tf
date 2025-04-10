data "aws_iam_policy_document" "ecs_task_execution_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_policy" "get_secret_bia_db_policy" {
  name = "get-secret-bia-db-policy"
  description = "Permite acesso ao cofre do RDS da BIA"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Resource = data.aws_secretsmanager_secret.bia_db.arn
      }
    ]
  })
  tags = { CreatedBy = local.terraform }
}

resource "aws_iam_role" "ecs_task_execution_role" {
  #name_prefix        = "fmctf-ecs-task-execution-role"
  name = "fmctf-ecs-task-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
  description        = "Permite que o ECS chame servicos da AWS em seu nome."
  tags               = { CreatedBy = local.terraform }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_get_secret_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.get_secret_bia_db_policy.arn
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.ecs_task_execution_role.name
}