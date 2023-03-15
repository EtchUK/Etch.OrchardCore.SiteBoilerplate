output "cloudfront" {
  value = aws_wafv2_ip_set.cloudfront.arn
}

output "cloudfront_ip_restriction_arn" {
  value = aws_wafv2_web_acl.cloudfront_ip_restriction.arn
}