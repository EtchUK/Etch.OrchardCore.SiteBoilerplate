resource "aws_cloudfront_distribution" "cloudfront" {
  origin {
    domain_name = var.domain_name
    origin_id   = var.origin_id

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = var.origin_protocol_policy
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = var.secret_header_name
      value = var.secret_header_value
    }
  }

  aliases         = var.aliases
  enabled         = true
  is_ipv6_enabled = true
  web_acl_id      = var.web_acl

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = var.origin_id

    forwarded_values {
      headers = [
        "Host",
      ]

      query_string = true

      cookies {
        forward           = "whitelist"
        whitelisted_names = ["orchauth_*", "__orchantiforgery_*"]
      }
    }

    viewer_protocol_policy = "redirect-to-https"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn            = var.certificate
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  tags = {
    Name = var.project
  }
}