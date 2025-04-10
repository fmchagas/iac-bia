resource "aws_ecs_service" "fmc_bia_web" {
  name            = "service-bia-web"
  cluster         = aws_ecs_cluster.cluster_bia.id
  task_definition = aws_ecs_task_definition.fmc_bia_web.arn
  desired_count   = 2

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.cluster_bia_cp.name
    base   = 1
    weight = 100
  }

  ordered_placement_strategy {
    type  = "spread"
    field = "attribute:ecs.availability-zone"
  }

  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 100

  depends_on = [ aws_lb_target_group.tg_bia ]

  load_balancer {
    target_group_arn = aws_lb_target_group.tg_bia.arn
    container_name   = "bia" # Nome do contêiner definido na Task Definition
    container_port   = 8080 # Porta exposta pelo contêiner
  }

  # lifecycle {
  #   ignore_changes = [ desired_count ]
  # }

  tags = {
    CreatedBy = local.terraform
  }
  
}
