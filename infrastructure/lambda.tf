module "payment_lambda"{
  source = "./terraform_modules/lambda"
  env_vars = {"dynamodb_table_name" : aws_dynamodb_table.payment-dynamodb-table.name}
  lambda_function_name = "nav_payment_module"
  handler_name       = "app_payment.lambda_handler"
  lambda_policy      = data.aws_iam_policy_document.payment_lambda_policy.json
  lambda_script_path = "./scripts/app_payment.py"
}

module "invoice_lambda"{
  source = "./terraform_modules/lambda"
  env_vars = {"dynamodb_table_name" : aws_dynamodb_table.payment-dynamodb-table.name}
  lambda_function_name = "nav_invoice_module"
  handler_name       = "app_invoice.lambda_handler"
  lambda_policy      = data.aws_iam_policy_document.invoice_lambda_policy.json
  lambda_script_path = "./scripts/app_invoice.py"
}


data "aws_iam_policy_document" "payment_lambda_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem"
    ]

    resources = [
      "${module.payment_lambda.lambda_log_group_arn}:*",
      aws_dynamodb_table.payment-dynamodb-table.arn,
      "${aws_dynamodb_table.payment-dynamodb-table.arn}/*",
    ]
  }
}

data "aws_iam_policy_document" "invoice_lambda_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:PutItem",
      "dynamodb:GetItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem"
    ]

    resources = [
      "${module.invoice_lambda.lambda_log_group_arn}:*",
      aws_dynamodb_table.payment-dynamodb-table.arn,
      "${aws_dynamodb_table.payment-dynamodb-table.arn}/*",
    ]
  }
}

