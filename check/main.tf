resource "aws_security_group" "fail" {

}

resource "aws_security_group" "fail2" {
  tags = {
    component = "fail"
    flag      = "fail"
  }
}


resource "aws_security_group" "pass" {
  tags = {
    component = "pass"
    flag      = "pass"
  }
}

resource "aws_security_group" "pass2" {
  tags = {
    component = "correct"
    flag      = "pass"
  }
}

#not all resources are taggable
resource "aws_acm_certificate_validation" "nottaggable" {
  certificate_arn         = aws_acm_certificate.cert.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}