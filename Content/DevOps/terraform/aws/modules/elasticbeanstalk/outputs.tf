output "elb_id" {
  value = aws_elastic_beanstalk_environment.ebe.id
}

output "elb_dns" {
  value = aws_elastic_beanstalk_environment.ebe.cname
}