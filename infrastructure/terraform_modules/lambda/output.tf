output "lambda_name" {
  value = aws_lambda_function.test_lambda.function_name
}

output "lambda_arn" {
  value = aws_lambda_function.test_lambda.arn
}

output "lambda_log_group_arn" {
  value = aws_cloudwatch_log_group.lambda_log_group.arn
}