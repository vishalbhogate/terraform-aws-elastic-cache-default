resource "aws_ssm_parameter" "elasticache_address" {
  count       = var.enabled ? 1 : 0
  name        = "/elasticache/${var.name}/HOST"
  description = "${upper(var.engine)} Hostname"
  type        = "String"
  value       = aws_elasticache_cluster.elasticache_cluster[count.index].cache_nodes[count.index].address
}

resource "aws_ssm_parameter" "elasticache_port" {
  count       = var.enabled ? 1 : 0
  name        = "/elasticache/${var.name}/PORT"
  description = "${upper(var.engine)} PORT"
  type        = "String"
  value       = aws_elasticache_cluster.elasticache_cluster[count.index].cache_nodes[count.index].port
}
