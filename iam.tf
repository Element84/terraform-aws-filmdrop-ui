resource "aws_iam_role" "console_ui_codebuild_iam_role" {
  name_prefix = "console-ui-build-role"

  assume_role_policy = data.aws_iam_policy_document.console_ui_codebuild_assume_role.json
}

data "aws_iam_policy_document" "console_ui_codebuild_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "console_ui_codebuild_policy" {
  statement {
    sid    = "CodeBuildPolicy"
    effect = "Allow"

    actions = [
      "acm:*",
      "waf:*",
      "codebuild:*",
      "eks:*",
      "kms:*",
      "iam:*",
      "ecr:*",
      "lambda:*",
      "sns:*",
      "ssm:*",
      "s3:*",
      "firehose:*",
      "logs:*",
      "ec2:*",
      "es:*",
      "sqs:*",
      "apigateway:*",
      "cognito-idp:*",
      "dynamodb:*",
      "wafv2:*",
      "cloudfront:*",
      "cloudformation:*",
      "route53:*",
      "events:*",
      "ecs:*",
      "cloudwatch:*",
      "sts:Decode*"
    ]

    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "console_ui_codebuild_iam_policy" {
  role   = aws_iam_role.console_ui_codebuild_iam_role.name
  policy = data.aws_iam_policy_document.console_ui_codebuild_policy.json
}