resource "aws_cloudwatch_metric_alarm" "cache_cpu" {
  count               = var.enabled ? 1 : 0
  alarm_name          = "${var.name}-cpu-utilization-${data.aws_region.current.name}"
  alarm_description   = "Memcached cluster CPU utilization"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/ElastiCache"
  period              = 300
  statistic           = "Average"

  threshold = var.alarm_cpu_threshold_percent

  dimensions = {
    CacheClusterId = var.name
  }

  alarm_actions = var.alarm_sns_topics
  depends_on    = [aws_elasticache_cluster.elasticache_cluster]
}

resource "aws_cloudwatch_metric_alarm" "cache_memory" {
  count               = var.enabled ? 1 : 0
  alarm_name          = "${var.name}-freeable-memory-${data.aws_region.current.name}"
  alarm_description   = "Memcached cluster freeable memory"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 1
  metric_name         = "FreeableMemory"
  namespace           = "AWS/ElastiCache"
  period              = 60
  statistic           = "Average"

  threshold = var.alarm_memory_threshold_bytes

  dimensions = {
    CacheClusterId = var.name
  }

  alarm_actions = var.alarm_sns_topics
  depends_on    = [aws_elasticache_cluster.elasticache_cluster]
}