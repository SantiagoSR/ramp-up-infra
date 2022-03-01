
resource "aws_launch_template" "template-ramp-up-ssr" {
  name_prefix = "template-ramp-up-ssr"
  image_id = var.image_instance
  instance_type = "t2.micro"
  key_name = "RampUp-devops-santiago.santacruzr"
  user_data = filebase64("./user-data/script.sh")
  vpc_security_group_ids = ["${var.security_groups}"]
  tag_specifications  {
    resource_type = "volume"
    tags = {
      project     = var.instance_project,
      responsible = var.instance_responsile
    }
  }
  tag_specifications  {
    resource_type = "instance"
    tags = {
      project     = var.instance_project,
      responsible = var.instance_responsile,
      Name = "Web Server",
    }
  }
}

resource "aws_autoscaling_group" "auto-scaling-ramp-up-ssr" {
  desired_capacity = 2
  max_size = 3
  min_size = 1
  vpc_zone_identifier = ["subnet-0d74b59773148d704","subnet-038fa9d9a69d6561e"]

  launch_template {
    id = aws_launch_template.template-ramp-up-ssr.id
    version = aws_launch_template.template-ramp-up-ssr.latest_version

  }

  tags = [ {
    Name = var.auto_scaling_ramp_up_name,
  } ]
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.auto-scaling-ramp-up-ssr.id
  alb_target_group_arn = "${var.alb_target_group}"
}