resource "aws_cloudwatch_event_rule" "payment_event_rule" {
  name = "paymentEventRule"

  event_pattern = jsonencode({
    detail = {
      event_type = ["payment"]
    }
  })
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = module.payment_lambda.lambda_name
  source_arn    = aws_cloudwatch_event_rule.payment_event_rule.arn
}

resource "aws_cloudwatch_event_target" "payment_event_target" {
  rule      = aws_cloudwatch_event_rule.payment_event_rule.name
  target_id = "paymentLambdaTarget"
  arn       = module.payment_lambda.lambda_arn
}

resource "aws_cloudwatch_event_rule" "invoice_event_rule" {
  name = "InvoiceEventRule"

  event_pattern = jsonencode({
    detail = {
      event_type = ["invoice"]
    }
  })
}

resource "aws_lambda_permission" "allow_eventbridge_invoice" {
  statement_id  = "AllowEventBridgeInvokeInvoice"
  action        = "lambda:InvokeFunction"
  principal     = "events.amazonaws.com"
  function_name = module.invoice_lambda.lambda_name
  source_arn    = aws_cloudwatch_event_rule.invoice_event_rule.arn
}

resource "aws_cloudwatch_event_target" "invoice_event_target" {
  rule      = aws_cloudwatch_event_rule.invoice_event_rule.name
  target_id = "InvoiceLambdaTarget"
  arn       = module.invoice_lambda.lambda_arn
}