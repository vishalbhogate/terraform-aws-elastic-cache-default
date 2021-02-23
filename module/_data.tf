data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["prod-VPC"]
  }
}

data "aws_subnet_ids" "private" {
  vpc_id = data.aws_vpc.selected.id

  filter {
    name   = "tag:Scheme"
    values = ["private"]
  }
}