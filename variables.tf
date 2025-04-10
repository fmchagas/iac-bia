variable "instance_name" {
  description = "Nome da instancia"
  type        = string
  default = "bia-dev-ec2"
}

variable "availability_zone" {
  description = "A zona de disponibilidade"
  type        = string
  default     = "us-east-1a"
}