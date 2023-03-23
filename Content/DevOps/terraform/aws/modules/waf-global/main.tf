terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
}

resource "aws_wafv2_ip_set" "cloudfront" {
  name               = "PermittedIPsCloudfront${title(var.env)}"
  scope              = "CLOUDFRONT"
  ip_address_version = "IPV4"
  addresses          = var.permitted_ips

  tags = {
    Name = var.project
  }
}

resource "aws_wafv2_web_acl" "cloudfront_ip_restriction" {
  name  = "CloudFrontIPRestriction${title(var.env)}"
  scope = "CLOUDFRONT"

  default_action {
    block {}
  }

  rule {
    name     = "ip-restriction"
    priority = 1

    action {
      allow {}
    }

    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.cloudfront.arn
      }
    }

    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "ip-restriction"
      sampled_requests_enabled   = false
    }
  }

  visibility_config {
    cloudwatch_metrics_enabled = true
    metric_name                = "total"
    sampled_requests_enabled   = false
  }
}