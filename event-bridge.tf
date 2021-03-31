resource "aws_cloudwatch_event_rule" "lambda_rule" {
  name        = var.lambda_function
  description = "Email alerts for Macie Findings"

  event_pattern = <<EOF
{ 
    "source": [
        "aws.macie"
    ], 
    "detail-type": [
        "Macie Finding"
    ] 
}
EOF
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_rule.name
  target_id = "lambda"
  arn       = aws_lambda_function.lambda_function.arn
}

resource "aws_lambda_permission" "lambda_permissions" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.lambda_rule.arn
}