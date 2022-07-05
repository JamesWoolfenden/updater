resource "aws_security_group_rule" "lambda" {
  type              = "ingress"
  description       = "all to self"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  security_group_id = var.security_group_ids[0]
  self              = true
}