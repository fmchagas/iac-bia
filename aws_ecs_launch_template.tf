data "aws_ssm_parameter" "fmctf_ecs_node_iam" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id" #ami id, ou seja, a imagem recomenda pela AWS que será usada
}

resource "aws_launch_template" "fmctf_ecs_ec2" {
    name_prefix = "cluster-bia-web-"
    image_id = data.aws_ssm_parameter.fmctf_ecs_node_iam.value
    instance_type = "t3.micro"
    
    #vpc_security_group_ids = [ aws_security_group.bia_ec2_tf.id ]
    network_interfaces {
      associate_public_ip_address = true
      security_groups = [ aws_security_group.bia_ec2_tf.id ]
      #ipv6_address_count = true
    }

    iam_instance_profile { arn = aws_iam_instance_profile.fmctf_ecs_node.arn }
    monitoring {  enabled = false }

    # Associa o ASG com o cluster ecs
    user_data = base64encode(<<-EOF
     #!/bin/bash
     echo ECS_CLUSTER=${aws_ecs_cluster.cluster_bia.name} >> /etc/ecs/ecs.config;
     EOF
    )
}