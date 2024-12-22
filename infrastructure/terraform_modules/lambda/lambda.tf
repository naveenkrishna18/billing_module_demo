resource "aws_iam_role" "iam_for_lambda" {
  name               = "${var.lambda_function_name}-lambda-role"
  assume_role_policy = var.lambda_policy
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.lambda_script_path
  output_path = "${var.lambda_function_name}.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = data.archive_file.lambda.output_path
  function_name = var.lambda_function_name
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.handler_name
  source_code_hash = data.archive_file.lambda.output_base64sha256
  runtime = "python3.12"
  environment {
    variables = var.env_vars
    }
}

resource "aws_cloudwatch_log_group" "example" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
}