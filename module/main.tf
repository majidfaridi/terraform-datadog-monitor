resource "datadog_monitor" "default" {
  name                = var.dd_name
  type                = var.dd_type
  escalation_message  = var.dd_escalation_message
  query               = var.dd_query
  message             = var.dd_message
  include_tags        = var.dd_include_tags
  notify_no_data      = var.dd_notify_no_data
  require_full_window = var.dd_require_full_window
  monitor_thresholds {
    critical = var.dd_monitor_thresholds_critical
    warning  = var.dd_monitor_thresholds_warning
  }
  tags = ["${var.environment}"]
}