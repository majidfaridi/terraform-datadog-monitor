output "dd_name" {
  description = "DataDog name"
  value = [
    "${module.container-is-unhealthy.dd_name}",
    "${module.container-is-unhealthy.dd_name}",
    "${module.eC2-instance-is-down.dd_name}",
    "${module.ecs-memory-utilization-is-hight.dd_name}",
    "${module.free-memory-is-under.dd_name}",
    "${module.http-400-error-is-more-than-20rsps.dd_name}",
    "${module.http-500-error-is-more-than-10rsps.dd_name}",
    "${module.incoming-network-traffic-is-hight.dd_name}",
    "${module.outgoing-network-traffic-is-hight.dd_name}",
    "${module.ram-is-below.dd_name}",
    "${module.rds-cpu-utilization-is-hight.dd_name}",
    "${module.cpu-usage-is-hight.dd_name}",
    "${module.cpu-utilization-is-hight.dd_name}"
  ]
}
