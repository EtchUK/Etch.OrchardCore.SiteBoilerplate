resource "aws_wafv2_ip_set" "regional" {
  name               = "PermittedIPsRegional${title(var.env)}"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = var.permitted_ips

  tags = {
    Name = var.project
  }
}

resource "aws_wafv2_web_acl" "restrict_to_cloudfront" {
  name  = "RestrictCloudfront${title(var.env)}"
  scope = "REGIONAL"

  default_action {
    block {}
  }

  rule {
    name     = "check-secret-header"
    priority = 1

    action {
      allow {}
    }

    statement {
      byte_match_statement {
        field_to_match {
          single_header {
            name = var.secret_header_name
          }
        }

        positional_constraint = "EXACTLY"
        search_string         = var.secret_header_value

        text_transformation {
          type     = "NONE"
          priority = 1
        }
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "check-secret-header"
      sampled_requests_enabled   = false
    }
  }

  rule {
    name     = "check-originating-tcp-ip"
    priority = 2

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.regional.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "check-originating-tcp-ip"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "total"
    sampled_requests_enabled   = false
  }
}