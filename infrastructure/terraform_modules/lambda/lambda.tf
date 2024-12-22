resource "aws_iam_role" "iam_for_lambda" {
  name               = "${var.lambda_function_name}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.sts_lambda_policy.json
}

data "aws_iam_policy_document" "sts_lambda_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }

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

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = 14
}



resource "aws_iam_policy" "lambda_logging" {
  name        = "${var.lambda_function_name}_policy"
  path        = "/"
  description = "IAM policy for lambda"
  policy      = var.lambda_policy
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_logging.arn
}