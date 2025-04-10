resource "aws_ecs_capacity_provider" "cluster_bia_cp" {
  name = "cluster-bia-cp"

  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.fmctf_ecs.arn
    managed_termination_protection = "DISABLED"

    managed_scaling {
      maximum_scaling_step_size = 1
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 100
    }

  }
}

resource "aws_ecs_cluster_capacity_providers" "main" {
  cluster_name       = aws_ecs_cluster.cluster_bia.name
  capacity_providers = [aws_ecs_capacity_provider.cluster_bia_cp.name]

  default_capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.cluster_bia_cp.name
    base              = 1
    weight            = 100
  }
}
