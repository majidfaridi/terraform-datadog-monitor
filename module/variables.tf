variable "dd_name" {
  type        = string
  description = "DataDog Name"
}

variable "dd_type" {
  type        = string
  description = "DataDog type"
}

variable "dd_escalation_message" {
  type        = string
  description = "DataDog escalation message"
}

variable "dd_query" {
  type        = string
  description = "DataDog query"
}

variable "dd_message" {
  type        = string
  description = "DataDog message"
}

variable "dd_include_tags" {
  type        = bool
  description = "DataDog nclude tags"
}

variable "dd_notify_no_data" {
  type        = bool
  description = "DataDog notify no data"
}

variable "dd_require_full_window" {
  type        = bool
  description = "DataDog require full window"
}

variable "dd_monitor_thresholds_critical" {
  type        = string
  description = "DataDog require full window"
}

variable "dd_monitor_thresholds_warning" {
  type        = string
  description = "DataDog require full window"
}

variable "environment" {
  type        = string
  description = "Resource Environment"
}
