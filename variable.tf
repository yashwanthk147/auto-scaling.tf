variable "vpc_id" {
  type = string
  description = "The ID of the VPC to use"

  validation {
    condition     = length(var.vpc_id) > 0 && can(regex("vpc-[a-zA-Z0-9]+", var.vpc_id))
    error_message = "vpc_id must be a valid AWS VPC ID (e.g. vpc-0123456789abcdef)"
  }
}
variable "security_group_id" {
  type = string
  description = "ID of the security group to associate with the EC2 instance"

  validation {
    condition = can(regex("^sg-[0-9a-f]{8,17}$", var.security_group_id))
    error_message = "Invalid security group ID. Please enter a valid security group ID."
  }
}
/*variable "public_key" {
  type = string
  description = "SSH public key"
}
variable "private_key" {
  type = string
  description = "Private key for authentication"
}*/
variable "key_name" {
  type = string
  description = "The name of the AWS key pair to use."
  
  validation {
    condition     = can(regex("^([a-zA-Z0-9-_]+$)", var.key_name))
    error_message = "Key name must consist only alphanumeric characters, hyphens, and underscores."
  }
}
variable "Environment" {
   type = string
   description = "key must be dev, staging or prod"
  }

variable "min_size" {
  type = number
  description = "Minimum size of the autoscaling group"
  
  validation {
    condition     = var.min_size >= 1
    error_message = "Minimum size must be at least 1"
  }
}
variable "desired_capacity" {
  type = number
  description = "The desired capacity must be equal to or greater than the minimum group size, and equal to or less than the maximum group size"

  validation {
    condition = (var.desired_capacity >= 1 && var.desired_capacity <= 100)
    error_message = "Desired capacity must be between 1 and 100"
  }
}
variable "max_size" {
  type = number
  description = "Maximum size of the autoscaling group"

  validation {
    condition     = (var.max_size >= 1 && var.max_size <= 100)
    error_message = "Max size must be between 1 and 100"
  }
}
variable "health_check_grace_period" {
  type = number
  description = "The amount of time, in seconds, that the autoscaling group should wait before checking the health status of an EC2 instance after it comes into service."

  validation {
    condition = (var.health_check_grace_period >= 0 && var.health_check_grace_period <= 3600)
    error_message = "The health_check_grace_period must be a number between 0 and 3600 seconds."
  }
}
variable "default_cooldown" {
  type = number
  description = "The default cooldown period for the autoscaling group"

  validation {
    condition     = (var.default_cooldown >= 60 && var.default_cooldown <= 86400)
    error_message = "The default cooldown period must be between 60 and 86400 seconds"
  }
}
variable "value" {
  type = string
}
variable "min_healthy_percentage" {
  type = number
  description = "At least this percentage of the desired capacity of the Auto Scaling group must remain healthy during this operation to allow it to continue."

  validation {
    condition     = (var.min_healthy_percentage >= 0 && var.min_healthy_percentage <= 100)
    error_message = "The minimum healthy percentage must be an integer between 0 and 100"
  }
}
variable "instance_warmup" {
  type = number
  description = "How much time it takes a newly launched instance to be ready to use."

  validation {
    condition = (var.instance_warmup >= 0 && var.instance_warmup <= 3600)
    error_message = "instance_warmup must be between 0 and 3600 seconds."
  }
}
variable "heartbeat_timeout" {
  type = number
  description = "The maximum number of seconds before allowing another scaling activity"

  validation {
    condition = (var.heartbeat_timeout > 0 && var.heartbeat_timeout <= 300)
    error_message = "Heartbeat timeout must be between 1 and 300 seconds."
  }
}
variable "instance_type" {
  type = string
  description = "The EC2 instance type"
}
variable "launch_template_name" {
  type = string
  description = "Name of the AWS Launch Template"
}
variable "lb_name" {
  type = string
  description = "Name of the LoadBalancer"
}
variable "lb_target_group_name" {
  type = string
  description = "Name of the LoadBalancer target group"
}
variable "autoscaling_group_name" {
  type = string
  description = "Name of the Autoscaling group"
}
variable "security_group_name" {
  type = string
  description = "Name of the Security group for LB"
}
variable "source_instance_id" {
  type = string
  description = "ID of the source instance."

  validation {
    condition     = length(var.source_instance_id) > 0 && can(regex("^i-[a-zA-Z0-9]{8,}$", var.source_instance_id))
    error_message = "Invalid instance ID format. It should be in the format 'i-01eabe382a61f26b8'"
  }
}
variable "image_id" {
  type = string
  description = "The id of the machine image (AMI) to use for the server."
}
variable "private_subnets" {
  type = list(string)
}
variable "public_subnets" {
  type = list(string)
}
/*variable "upper_threshold" {
  type = string
  description = "Please provide upper threshold value."
}
variable "lower_threshold" {
  type = string
  description = "Please provide lower threshold value."
}*/
variable "certificate_arn" {
  type = string
  description = "Certificate ARN for lb_listener "
}
variable "ssl_policy" {
  type = string 
  description = "ssl policy"
}
variable "notification_target_arn" {
  type = string
  description = "Notification target ARN for lifecycle hook"
}
variable "role_arn" {
  type = string
  description = "Role ARN for lifecycle hook"
}
variable "healthpath" {
  type = string
  description = "Path for health check"
}

variable "target_value" {
  type = string
  description = "No of requests to be placed for request based autoscaling policy"
}

