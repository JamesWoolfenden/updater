resource "aws_vpc_endpoint" "s3" {
  vpc_id       = "vpc-0c33dc8cd64f408c4"
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"
}



resource "aws_vpc_endpoint_route_table_association" "s3" {
  route_table_id  = var.route_table_id
  vpc_endpoint_id = aws_vpc_endpoint.s3.id
}

# resource "aws_vpc_endpoint" "kms" {
#   vpc_id       = "vpc-0c33dc8cd64f408c4"
#   service_name = "com.amazonaws.${data.aws_region.current.name}.kms"
# }
