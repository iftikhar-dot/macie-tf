# Create lambda role with assume policy
resource "aws_iam_role" "macie-msg" {
  name = var.macie-msg
  path = "/service-role/"
  assume_role_policy=<<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        { 
            "Effect": "Allow", 
            "Principal": {
                "Service": "lambda.amazonaws.com"
            }, 
            "Action": "sts:AssumeRole"
        }
    ]
}
EOF
}

# Attach Managed Policies
resource "aws_iam_role_policy_attachment" "lambda_basic_policy" {
  role       = aws_iam_role.macie-msg.id
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy" "lambda_sns_policy" {
  name    = "lambda-sns-publish-policy"
  role    = aws_iam_role.macie-msg.id
  policy  = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "sns:Publish",
            "Resource": "${aws_sns_topic.sns_topic.arn}"
        }
    ]
}
EOF
}