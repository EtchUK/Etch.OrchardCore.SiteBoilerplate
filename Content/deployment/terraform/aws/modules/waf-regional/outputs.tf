output "regional" {
  value = aws_wafv2_ip_set.regional.arn
}

output "restrict_to_cloudfront_arn" {
  value = aws_wafv2_web_acl.restrict_to_cloudfront.arn
}