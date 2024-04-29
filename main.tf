resource "aws_lexv2models_bot" "this" {
  name                        = "${local.stack}-lex-bot"
  description                 = var.description
  idle_session_ttl_in_seconds = var.idle_session_ttl_in_seconds
  role_arn                    = var.role_arn
  type                        = var.type

  data_privacy {
    child_directed = var.child_directed
  }

  members {
    alias_id   = ""
    alias_name = ""
    id         = ""
    name       = ""
    version    = ""
  }
}

resource "aws_lexv2models_bot_version" "this" {
  bot_id      = ""
  description = ""
  locale_specification = {
    (aws_lexv2models_bot_locale.this.locale_id) = {
      source_bot_version = var.source_bot_version
    }
  }
}

resource "aws_lexv2models_bot_locale" "this" {
  bot_id                           = ""
  bot_version                      = ""
  locale_id                        = ""
  description                      = ""
  n_lu_intent_confidence_threshold = var.n_lu_intent_confidence_threshold

  voice_settings {
    voice_id = ""
    engine   = ""
  }
}

resource "aws_lexv2models_intent" "this" {
  name        = ""
  description = ""
  bot_id      = aws_lexv2models_bot.this.id
  bot_version = aws_lexv2models_bot_locale.this.bot_version
  locale_id   = aws_lexv2models_bot_locale.this.locale_id
}

resource "aws_iam_role" "this" {
  name               = "${local.stack}-lex-role"
  description        = "IAM Role for ${local.stack}-lex-bot"
  assume_role_policy = data.aws_iam_policy_document.trust.json
}

resource "aws_iam_policy" "this" {
  name        = ""
  description = ""
  policy      = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  policy_arn = aws_iam_policy.this.arn
  role       = aws_iam_role.this.name
}
