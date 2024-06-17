resource "aws_launch_template" "web" {
  name = var.launch_template_name
  disable_api_stop        = true
  disable_api_termination = true
  image_id = var.image_id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.instance_type
  key_name = var.key_name
  monitoring {
    enabled = true
  }
  network_interfaces {
    associate_public_ip_address = false
    security_groups = [data.aws_security_group.ec2_sg.id]
  }
  # vpc_security_group_ids = [data.aws_security_group.ec2_sg.id]
  update_default_version = true
  user_data = filebase64("command.sh")
  block_device_mappings {
          device_name = "/dev/sda1"
          ebs {
            volume_size           = 300
            volume_type           = "gp3"
            encrypted             = true
            delete_on_termination = true
          }
      }
}
