variable "AWS_REGION" {
  type        = string
  description = "AWS Region"
}

variable "AWS_PROFILE" {
  type        = string
  description = "AWS Profile"
}

variable "datadog_secrets_id" {
  type        = string
  description = "DataDog secret id"
}

variable "environment" {
  type        = string
  description = "Resource Environment"
}

variable "slack_channel" {
  type        = string
  description = "Slack channel"
}

variable "service_region" {
  type        = string
  description = "Service region"
}