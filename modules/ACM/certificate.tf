# Create a SSL certificate

resource "aws_acm_certificate" "acm-certificate" {
  domain_name       = var.aws_domain_name # Change this to your domain name
  subject_alternative_names = [var.alt_aws_domain_name] # Change this to your alternative domain name
  validation_method = "DNS"


  lifecycle {
    create_before_destroy = true
  }
}

data "aws_route53_zone" "Route53-data" {
  name         = var.aws_domain_name # Change this to your domain name
  private_zone = false
}

resource "aws_route53_record" "sumnertech-cert-validation" {
  for_each = {
    for dvo in aws_acm_certificate.acm-certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = data.aws_route53_zone.Route53-data.zone_id
}

resource "aws_acm_certificate_validation" "certificate_validation" {
  certificate_arn         = aws_acm_certificate.acm-certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.sumnertech-cert-validation : record.fqdn]
}