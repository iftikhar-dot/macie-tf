resource "null_resource" "lambda_setup" {
  depends_on = [aws_sns_topic.sns_topic]

  triggers = {
      build_number = timestamp()
  }

  provisioner "local-exec" {
    command = "python3 setup.py --s3_bucket ${var.s3_bucket} --sns_topic_arn ${aws_sns_topic.sns_topic.arn}"
  }
}

resource "aws_lambda_function" "lambda_function" {
  function_name    = var.lambda_function
  description      = "Lambda function to Email Macie Findings"
  s3_bucket        = var.s3_bucket
  s3_key           = "lambda_function.zip" # its mean its depended on upload key
  memory_size      = 1024
  timeout          = 30
  runtime          = "python3.8"
  role             = aws_iam_role.macie-msg.arn
  handler          = "lambda_function.lambda_handler"
  
  depends_on = [null_resource.lambda_setup]
}