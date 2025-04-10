resource "aws_ecs_task_definition" "fmc_bia_web" {
  family        = "task-def-bia-web"
  network_mode  = "bridge"
  task_role_arn = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([{
    name  = "bia"
    image = "${aws_ecr_repository.bia_tf.repository_url}:latest"
    cpu   = 1024
    memoryReservation = 400
    essential = true
    portMappings = [{
      containerPort = 8080
      hostPort      = 0
    }]
    environment = [
      { name = "DB_PORT", value = "5432" },
      { name = "DB_HOST", value = aws_db_instance.bia.address },
      { name = "DB_SECRET_NAME", value = data.aws_secretsmanager_secret.bia_db.name },
      { name = "DB_REGION", value = "us-east-1" },
      { name = "DEBUG_SECRET", value = "true" }
    ]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-region"        = "us-east-1"
        "awslogs-group"         = aws_cloudwatch_log_group.ecs_bia_web.name
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])

  runtime_platform {
    cpu_architecture = "X86_64"
    operating_system_family = "LINUX"
  }

  tags = {
    CreatedBy = local.terraform
  }
}