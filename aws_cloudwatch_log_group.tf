resource "aws_cloudwatch_log_group" "ecs_bia_web" {
  name = "/ecs/task-def-bia-web"
  retention_in_days = 5
  tags = {
    #Name = "task-def-bia-web"
    CreatedBy = local.terraform
  }
  
}