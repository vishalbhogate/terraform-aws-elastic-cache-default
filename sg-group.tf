resource "aws_security_group" "elasticache_cluster_sg" {
  name        = "${var.name}-security-group"
  description = "${upper(var.engine)} Security Group"
  vpc_id      = var.vpc_id
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "elasticache_inbound_vpn" {
  type              = "ingress"
  from_port         = var.engine == "redis" ? 6379 : 11211
  to_port           = var.engine == "redis" ? 6379 : 11211
  protocol          = "tcp"
  cidr_blocks       = length(var.vpn_cidr) > 1 ? var.vpn_cidr : ["0.0.0.0/0"]
  security_group_id = aws_security_group.elasticache_cluster_sg.id
  description       = "VPN/VPC Access"
}

resource "aws_security_group_rule" "elasticache_inbound_service" {
  count                    = var.source_security_group_id != "" ? 1 : 0
  type                     = "ingress"
  from_port                = var.engine == "redis" ? 6379 : 11211
  to_port                  = var.engine == "redis" ? 6379 : 11211
  protocol                 = "tcp"
  source_security_group_id = var.source_security_group_id
  security_group_id        = aws_security_group.elasticache_cluster_sg.id
  description              = "From Service Nodes"
}