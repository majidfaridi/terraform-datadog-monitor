data "aws_secretsmanager_secret_version" "datadog_secrets" {
  secret_id = var.datadog_secrets_id
}

module "container-is-unhealthy" {
  source                         = "../modules/"
  dd_name                        = "Container is unhealthy on {{container_name.name}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "Container is unhealthy on {{container_name.name}}"
  dd_query                       = "avg(last_5m):avg:container.uptime{region:${var.service_region}} by {container_name} < 300"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "300"
  dd_monitor_thresholds_warning  = ""
  dd_message                     = <<EOM
Info:
`Container name: {{container_name.name}} `
`Environment: ${var.environment}`
Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}

module "eC2-instance-is-down" {
  source                         = "../modules/"
  dd_name                        = "EC2 instance is Down on {{host.ecs_cluster}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "EC2 instance is Down on {{host.ecs_cluster}}"
  dd_query                       = "max(last_5m):avg:aws.ec2.host_ok{region:${var.service_region}} by {host} < 1"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "1"
  dd_monitor_thresholds_warning  = ""
  dd_message                     = <<EOM
Info:
`Region:  {{host.region}}`
`Host Name:  {{host.name}} `
`ECS Cluster:  {{host.ecs_cluster}} `
`Environment: ${var.environment}`
Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}

module "ecs-memory-utilization-is-hight" {
  source                         = "../modules/"
  dd_name                        = "ECS Memory utilization is hight on {{host.name_tag}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "ECS Memory utilization is hight on {{host.name_tag}}"
  dd_query                       = "avg(last_5m):avg:aws.ecs.cluster.memory_utilization{region:${var.service_region}} by {clustername} > 90"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "90"
  dd_monitor_thresholds_warning  = "80"
  dd_message                     = <<EOM
Info:
`Region:  {{host.region}}`
`Host Name:  {{host.name_tag}} `
`ECS cluster:  {{host.ecs_cluster}} `
`Environment: ${var.environment}`
Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}

module "free-memory-is-under" {
  source                         = "../modules/"
  dd_name                        = "Free memory is under 1.3G on {{name.name}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "Free memory is under 1.3G on {{name.name}}"
  dd_query                       = "avg(last_10m):avg:aws.elasticache.freeable_memory{region:${var.service_region}} by {name} < 1400000000"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "1400000000"
  dd_monitor_thresholds_warning  = ""
  dd_message                     = <<EOM
Info:
`Region:  {{host.region}}`
`Host Name:  {{host.name}} `
`Environment: ${var.environment}`
Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}


module "http-400-error-is-more-than-20rsps" {
  source                         = "../modules/"
  dd_name                        = "HTTP 400 ERROR is more than 20rsps on {{loadbalancer.name}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "HTTP 400 ERROR is more than 20rsps on {{loadbalancer.name}}"
  dd_query                       = "sum(last_5m):avg:aws.applicationelb.httpcode_elb_4xx{region:${var.service_region}} by {loadbalancer}.as_count() > 20"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "20"
  dd_monitor_thresholds_warning  = ""
  dd_message                     = <<EOM
Info:
`Region:  {{host.region}}`
`Host Name:  {{host.name}} `
`ALB name:  {{loadbalancer.name}} `
`Environment: ${var.environment}`
Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}

module "http-500-error-is-more-than-10rsps" {
  source                         = "../modules/"
  dd_name                        = "HTTP 500 ERROR is more than 10rsps on {{loadbalancer.name}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "HTTP 500 ERROR is more than 10rsps on {{loadbalancer.name}}"
  dd_query                       = "sum(last_5m):sum:aws.applicationelb.httpcode_elb_5xx{region:${var.service_region}} by {loadbalancer}.as_count() > 10"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "10"
  dd_monitor_thresholds_warning  = ""
  dd_message                     = <<EOM
Info:
`Region:  {{host.region}}`
`Host Name:  {{host.name}} `
`ALB name:  {{loadbalancer.name}} `
`Environment: ${var.environment}`
Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}

module "incoming-network-traffic-is-hight" {
  source                         = "../modules/"
  dd_name                        = "Incoming network traffic is more than 300M on {{host.ecs_cluster}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "Incoming network traffic is more than 300M on {{host.ecs_cluster}}"
  dd_query                       = "avg(last_5m):avg:aws.ec2.network_in{region:${var.service_region}} by {host} > 315000000"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "315000000"
  dd_monitor_thresholds_warning  = ""
  dd_message                     = <<EOM
Info:
`Region:  {{host.region}}`
`Host Name:  {{host.name}} `
`ECS Cluster:  {{host.ecs_cluster}} `
`Environment: ${var.environment}`
Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}

module "outgoing-network-traffic-is-hight" {
  source                         = "../modules/"
  dd_name                        = "Outgoing network traffic is more than 300M on {{host.ecs_cluster}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "Outgoing network traffic is more than 300M on {{host.ecs_cluster}}"
  dd_query                       = "avg(last_5m):avg:aws.ec2.network_out{region:${var.service_region}} by {host} > 315000000"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "315000000"
  dd_monitor_thresholds_warning  = ""
  dd_message                     = <<EOM
Info:
`Region:  {{host.region}}`
`Host Name:  {{host.name}} `
`ECS Cluster:  {{host.ecs_cluster}} `
`Environment: ${var.environment}`
Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}

module "ram-is-below" {
  source                         = "../modules/"
  dd_name                        = "RAM is below 5% on {{host.name}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "RAM is below 5% on {{host.name}}"
  dd_query                       = "avg(last_5m):avg:system.mem.pct_usable{region:${var.service_region}} by {host} < 0.05"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "0.05"
  dd_monitor_thresholds_warning  = "0.1"
  dd_message                     = <<EOM
Info:
`Region:  {{host.region}}`
`Host Name:  {{host.name}} `
`ECS Cluster:  {{host.ecs_cluster}}`
`Environment: ${var.environment}`
Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}

module "rds-cpu-utilization-is-hight" {
  source                         = "../modules/"
  dd_name                        = "RDS CPU utilization is hight on {{host.name_tag}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "RDS CPU utilization is hight on {{host.name_tag}}"
  dd_query                       = "avg(last_5m):avg:aws.rds.cpuutilization{region:${var.service_region}} by {host} > 90"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "90"
  dd_monitor_thresholds_warning  = "80"
  dd_message                     = <<EOM
Info:
`Region:  {{host.region}}`
`Host Name:  {{host.name_tag}} `
`Host ID:  {{host.name}} `
`Environment: ${var.environment}`
Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}

module "cpu-usage-is-hight" {
  source                         = "../modules/"
  dd_name                        = "CPU usage is hight on {{host.name}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "CPU usage is hight on {{host.name}}"
  dd_query                       = "avg(last_5m):avg:system.cpu.user{region:${var.service_region}} by {host} > 90"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "90"
  dd_monitor_thresholds_warning  = "80"
  dd_message                     = <<EOM
Info:
  `Region:  {{host.region}}`
  `Host Name:  {{host.name}} `
  `ECS Cluster:  {{host.ecs_cluster}}`
  `Environment: ${var.environment}`
  Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}

module "cpu-utilization-is-hight" {
  source                         = "../modules/"
  dd_name                        = "CPU utilization is hight on {{host.name_tag}}"
  dd_type                        = "metric alert"
  dd_escalation_message          = "CPU utilization is hight on {{host.name_tag}}"
  dd_query                       = "avg(last_5m):avg:aws.ec2.cpuutilization{region:${var.service_region}} by {host} > 90"
  dd_include_tags                = true
  dd_notify_no_data              = false
  dd_require_full_window         = true
  dd_monitor_thresholds_critical = "90"
  dd_monitor_thresholds_warning  = "80"
  dd_message                     = <<EOM
Info:
`Region:  {{host.region}}`
`Host Name:  {{host.name_tag}} `
`Host ID:  {{host.name}} `
`Environment: ${var.environment}`
Channel name: ${var.slack_channel}
  EOM
  environment                    = var.environment
}
