variable "profile" {
  default     = "default"
  description = "Name of your profile inside ~/.aws/credentials"
}

variable "region" {
  description = "Defines where your app should be deployed"
}

variable "application_environment" {
  description = "Deployment stage e.g. 'staging', 'production', 'test', 'integration'"
}
