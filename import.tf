# import DB
/* import {
  id = "bia"
  to = aws_instance.bia
}
 */
# comandos
## terraform plan -generate-config-out=out_db.tf


# Import para security group
/* import {
  id = "sg-0a4712f6bcdf753e4"
  to = aws_security_group.bia_ec2_tf
}

import {
  id = "sg-0e0a191ba5eb16be0"
  to = aws_security_group.bia_web_tf
}

import {
  id = "sg-0d30a01f0216e1178"
  to = aws_security_group.bia_alb_tf
} */

## terraform plan -generate-config-out=output_sg.tf