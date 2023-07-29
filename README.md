# Terraform Datadog Monitor Module


[![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) 
![Code](https://img.shields.io/badge/Code-Terraform-informational?style=flat&logo=PowerShell&logoColor=blue)
[![LICENSE](https://img.shields.io/badge/license-Apache--2.0-blue?logo=apache)](https://github.com/IvorySQL/IvorySQL/blob/IVORY_REL_1_STABLE/LICENSE)
## Overview

The Terraform Datadog Monitor Module is a reusable and configurable module that allows you to create Datadog monitors effortlessly using Terraform. Datadog monitors enable you to monitor various aspects of your infrastructure and applications, and trigger alerts based on defined conditions.

## Features

- Create and manage Datadog monitors using Terraform.
- Support for various types of monitors, such as metric-based, service-based, log-based, etc.
- Easy-to-use and customizable configuration.

## Usage


## Details:
Add these variables as a secret manager in AWS, then copy the secret manager ARN.

```hcl
{"DATADOG_API_KEY":"XXXXXXXXXXXXXX",
"DATADOG_APP_KEY":"XXXXXXXXXXXXXXX",
"DATADOG_API_URL":"https://api.datadoghq.eu"}
``` 

The below section in the main example file defines our AWS secret manager which we have used for our credential variables.

```hcl
data "aws_secretsmanager_secret_version" "datadog_secrets" {
  secret_id = var.datadog_secrets_id
}
```

This section in the provider file shows credential details which are going take from the AWS secret manager.

```hcl
provider "datadog" {
  api_key = jsondecode(data.aws_secretsmanager_secret_version.datadog_secrets.secret_string)["DATADOG_API_KEY"]
  app_key = jsondecode(data.aws_secretsmanager_secret_version.datadog_secrets.secret_string)["DATADOG_APP_KEY"]
  api_url = jsondecode(data.aws_secretsmanager_secret_version.datadog_secrets.secret_string)["DATADOG_API_URL"]
}
```

## Notice
Please change these variables has been defined between `__VARIABLES__`


## Init

---------
First of all, you should clone this repo to your local machine. I provided modules with simple examples. After, go to the needed example and run the next command:

```bash
$ terrafrom init
```

This command will init everything to provision module(s).


## Plan
---------
When you set `terraform init` you will be able to see which services are going to create with the next command:

```bash
$ terraform plan
```

## Apply
---------
To apply your stack, you can use:

```bash
$ terraform apply
```

## Destroy
---------
To terminate the stack, use:

```bash
$ terraform destroy
```


```hcl
resource "datadog_monitor" "default" {
  name                = var.dd_name
  type                = var.dd_type
  query               = var.dd_query
  escalation_message  = var.dd_escalation_message
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
```

Requirements
* Terraform version 0.12.x or newer
* Datadog API and Application Key


## Inputs
```bash
|---------------------------------|----------------------------------------------------------------|--------|-----------|----------|
|     Name                        |                  Description                                   |  Type  |  Default  | Required |
|:-------------------------------:|:--------------------------------------------------------------:|:------:|:---------:|:--------:|
| dd_name                         | Name of the monitor                                            | string | n/a       | yes      |
| dd_type                         | Type of the monitor                                            | string | n/a       | yes      |
| query                           | Query of the monitor                                           | string | n/a       | yes      |
| escalation_message              | Message included with a re-notification for this monitor       | string | n/a       | yes      |
| message                         | Message included with notifications for this monitor           | string | n/a       | yes      |
| dd_include_tags                 | Automatically inserts notifications its triggering tags        | bool   | []        | no       |
| dd_notify_no_data               | Whether or not this monitor notifies when data stops reporting | bool   | []        | no       |
| dd_require_full_window          | the monitor needs a full window of data before it is evaluated | bool   | []        | no       |
| dd_monitor_thresholds_critical  | The threshold value for the monitor                            | string | []        | no       |
| dd_monitor_thresholds_warning   | The threshold value for the monitor                            | string | n/a       | no       |
| environment                     | List of tags associated with the monitor.                      | string | n/a       | no       |
|---------------------------------|----------------------------------------------------------------|--------|-----------|----------|

```


## Outputs
```bash
|-------------------|--------------------------------------|
|        Name       |              Description             |
|:-----------------:|:------------------------------------:|
| dd_name           | The name of the created monitor      |
|-------------------|--------------------------------------|
```




# License

This project is licensed under the MIT License - see the LICENSE file for details.

# Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please create a pull request or open an issue in the repository.
