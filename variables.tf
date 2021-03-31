variable "profile" {
  description = "AWS Profile"
  default = "default"
}

variable "region" {
  description = "AWS Region"
  default = "us-east-1"
}

################### SNS Variables #################
variable "sns_topic_name" {
  description = "AWS SNS Topic Name"
  default = "macie-msg"
}

variable "protocol" {
  description = "The protocol you want to use."
  default = "email"
}

variable "notification_endpoint" {
  description = "The notification-endpoint that you want to receive notifications."
  default = "erich.ej.best@gmail.com" 
}

##################### Iam variables #######################

variable "macie-msg" {
  description = "Lambda Role Name"
  default = "macie-msg"
}

###################### Lambda variables #######################

variable "lambda_function" {
  description = "Lambda Function Name"
  default = "macie-msg"
}

variable "s3_bucket" {
  description = "S3 Bucket to upload lambda code"
  default = "aws-lambda-api-poc-bucket"
}