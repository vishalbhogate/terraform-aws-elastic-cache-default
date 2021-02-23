resource "aws_elasticache_subnet_group" "elasticache_subnet_group" {
  name       = "${var.name}-subnet-group"
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "elasticache_cluster" {
  count                        = var.enabled ? 1 : 0
  apply_immediately            = var.apply_immediately
  cluster_id                   = var.name
  engine                       = var.engine
  engine_version               = var.engine_version
  node_type                    = var.node_type
  num_cache_nodes              = var.cluster_size
  parameter_group_name         = var.parameter_group_name
  subnet_group_name            = aws_elasticache_subnet_group.elasticache_subnet_group.name
  security_group_ids           = [aws_security_group.elasticache_cluster_sg.id]
  notification_topic_arn       = var.notification_topic_arn
  port                         = var.engine == "redis" ? 6379 : 11211
  az_mode                      = var.engine == "redis" ? null : var.cluster_size == 1 ? "single-az" : "cross-az"
  preferred_availability_zones = [for n in range(0, var.cluster_size) : element(data.aws_availability_zones.available.names, n)]
  tags = merge(
    var.tags,
    {
      "Name"   = "${var.name}"
      "Scheme" = "secure"
    }
  )
}