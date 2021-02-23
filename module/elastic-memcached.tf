module "default" {
  source               = "../"
  enabled              = true
  name                 = "test"
  engine               = "memcached"
  engine_version       = "1.6.6"
  node_type            = "cache.t2.micro"
  cluster_size         = 1
  parameter_group_name = "default.memcached1.6"
  vpn_cidr             = ["10.0.0.0/0"]
  subnet_ids           = data.aws_subnet_ids.private.ids
  vpc_id               = data.aws_vpc.selected.id
}

module "default-redis" {
  source               = "../"
  enabled              = true
  name                 = "test-redis"
  engine               = "redis"
  engine_version       = "3.2.10"
  node_type            = "cache.t2.micro"
  cluster_size         = 1
  parameter_group_name = "default.redis3.2"
  vpn_cidr             = ["10.0.0.0/0"]
  subnet_ids           = data.aws_subnet_ids.private.ids
  vpc_id               = data.aws_vpc.selected.id
}