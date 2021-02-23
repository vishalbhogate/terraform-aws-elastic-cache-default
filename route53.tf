resource "aws_route53_record" "elasticache_record" {
  count   = var.enabled && var.zone_id != "" ? 1 : 0
  zone_id = var.zone_id
  name    = var.name
  type    = "CNAME"
  ttl     = "60"

  records = [join("", aws_elasticache_cluster.elasticache_cluster[count.index].cache_nodes[count.index].address)]
}