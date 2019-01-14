provider "aws" {
  profile = "${var.profile}"
  region  = "${var.region}"
}

resource "aws_kinesis_stream" "postmates_homework_stream" {
  name             = "postmates_homework_stream_${var.application_environment}"
  shard_count      = 1
  retention_period = 48

  shard_level_metrics = [
    "IncomingBytes",
    "OutgoingBytes",
  ]

  tags = {
    Environment = "Postmates Homework Stream ${var.application_environment}"
  }
}

