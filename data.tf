data "aws_region" "current" {

}

data "aws_caller_identity" "current" {

}

data "aws_iam_policy_document" "trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lexv2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    effect  = "Allow"
    actions = ["polly:SynthesizeSpeech"]
    resources = [
      "arn:aws:polly:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:lexicon/*"
    ]
  }
}
