resource "aws_placement_group" "bastion" {
  name     = "bastion"
  strategy = "cluster"
}

resource "aws_autoscaling_group" "bar" {
  name                      = "bastion"
  max_size                  = 1
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  desired_capacity          = 1
  force_delete              = true

  #  placement_group           = "${aws_placement_group.bastion.id}"
  launch_configuration = "${aws_launch_configuration.as_conf.name}"
  vpc_zone_identifier  = ["${var.subnet_id}"]

#  initial_lifecycle_hook {
#    name                 = "bastion_lifecycle"
#    default_result       = "CONTINUE"
#    heartbeat_timeout    = 2000
#    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

    #    notification_target_arn = "arn:aws:sqs:us-east-1:444455556666:queue1*"
    #    role_arn                = "arn:aws:iam::123456789012:role/S3Access"
#  }

  tag {
    key                 = "name"
    value               = "cs642"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }

  tag {
    key                 = "automated"
    value               = "terraform"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
