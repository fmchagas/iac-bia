
resource "aws_instance" "bia_dev_instance_tf" {
  ami           = "ami-00a929b66ed6e0de6" #"ami-02f3f602d23f1659d"
  instance_type = "t3.micro"
  tags = {
    Name      = var.instance_name
    CreatedBy = local.terraform
  }
  subnet_id                   = local.subnet_id_zona_a
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.bia_dev_tf.id]
  key_name                    = "fmc-ssh-aws"
  root_block_device {
    volume_size = 8
  }
  iam_instance_profile = aws_iam_instance_profile.acesso_ssm_role.name
  user_data            = file("userdata_biadev.sh")
}


#cmd: terraform apply -var 'instance_name=bia-dev-tf2'
# terraform state list
# terraform state show aws_security_group.bia-dev-tf
# terraform import aws_security_group.bia-dev-tf sg-0b3b3b3b3b3b3b3b3
# terraform import aws_instance.bia-dev i-03ee514bbc0fca7da
# migrar para usar backend local ou s3: terraform init -migrate-state
# terraform import aws_security_group.bia-dev sg-0dd647692cfb74030
# terraform plan -generate-config-out=out_iam.tf
# terraform destroy -target='aws_instance.bia-dev', terraform destroy -target aws_instance.bia-dev
# terraform apply --target aws_instance.bia_dev_instance_tf