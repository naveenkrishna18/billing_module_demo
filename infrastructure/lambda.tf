module "payment_lambda"{
  source = "./terraform_modules/lambda"
  env_vars = {"foo" : "bar"}
  lambda_function_name = "nav_payment_module"
  handler_name       = "app.lambda_handler"
  lambda_policy      = data.aws_iam_policy_document.lambda_policy.json
  lambda_script_path = "./scripts/app.py"
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }

}
