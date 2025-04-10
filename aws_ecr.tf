resource "aws_ecr_repository" "bia_tf" {
  name = "bia"
  image_tag_mutability = "MUTABLE"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = false
  }
}