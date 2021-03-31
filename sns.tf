resource "aws_sns_topic" "sns_topic" {
    name = var.sns_topic_name
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = var.protocol
  endpoint  = var.notification_endpoint
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn = aws_sns_topic.sns_topic.arn

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Id": "default",
    "Statement":[
        {
            "Sid": "TrustCWEToPublishEventsToMyTopic",
            "Effect": "Allow",
            "Principal": {
                "Service": "lambda.amazonaws.com"
            },
            "Action": "sns:Publish",
            "Resource": "${aws_sns_topic.sns_topic.arn}"
        }
    ]
}
POLICY
}