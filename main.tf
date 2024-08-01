resource "alicloud_cs_managed_kubernetes" "k8s" {
  name         = var.name
  cluster_spec = var.cluster_spec

  worker_vswitch_ids = var.control_plane_vswitch_ids
  pod_vswitch_ids    = var.pod_vswitch_ids
  node_cidr_mask     = var.node_cidr_mask
  proxy_mode         = var.proxy_mode
  service_cidr       = var.service_cidr
  new_nat_gateway    = true

  slb_internet_enabled = var.enabled_internet_access
  deletion_protection  = var.deletion_protection
  timezone             = var.timezone

  addons {
    name   = "terway-eniip"
    config = "{\"IPVlan\":\"${var.enable_datapath_v2}\",\"NetworkPolicy\":\"${var.enable_network_policy}\"}"
  }
  addons {
    name = "csi-plugin"
  }
  addons {
    name = "csi-provisioner"
  }

  dynamic "maintenance_window" {
    for_each = var.enable_maintenance_window ? [1] : []
    content {
      enable           = var.enable_maintenance_window
      maintenance_time = var.maintenance_window_time
      duration         = var.maintenance_window_duration
      weekly_period    = var.maintenance_window_weekly_period
    }
  }
  tags = {
    team        = var.label_team
    environment = var.label_environment
  }
}

resource "alicloud_cs_kubernetes_node_pool" "default" {
  for_each = var.node_pools

  node_pool_name       = each.key
  cluster_id           = alicloud_cs_managed_kubernetes.k8s.id
  vswitch_ids          = each.value.node_pool_vswitch_ids
  instance_types       = each.value.instance_type_ids
  system_disk_category = each.value.system_disk_category
  system_disk_size     = each.value.system_disk_size
  key_name             = each.value.key_name
  image_type           = each.value.image_type
  multi_az_policy      = each.value.multi_az_policy

  tags = {
    team        = var.label_team
    environment = var.label_environment
  }

  dynamic "labels" {
    for_each = each.value.taints
    content {
      key   = taints.value.key
      value = taints.value.value
    }
  }

  dynamic "taints" {
    for_each = each.value.taints
    content {
      key    = taints.value.key
      value  = taints.value.value
      effect = taints.value.effect
    }
  }

  management {
    enable = true

    auto_repair = true
    auto_repair_policy {
      restart_node = true
    }

    auto_upgrade = true
    auto_upgrade_policy {
      auto_upgrade_kubelet = true
    }

    auto_vul_fix = true
    auto_vul_fix_policy {
      vul_level    = "asap"
      restart_node = true
    }

    max_unavailable = 1
  }

  scaling_config {
    enable   = each.value.enable_auto_scaling
    min_size = each.value.min_size
    max_size = each.value.max_size
  }

  rolling_policy {
    max_parallelism = 1
  }

  kubelet_configuration {
    eviction_soft = {
      "memory.available" : each.value.eviction_soft_memory
      "nodefs.available"   = "5%"
      "nodefs.inodesFree"  = "3%"
      "imagefs.available"  = "5%"
      "imagefs.inodesFree" = "3%"
    }
    eviction_soft_grace_period = {
      "memory.available" : each.value.eviction_soft_grace_period,
      "nodefs.available" : each.value.eviction_soft_grace_period,
      "nodefs.inodesFree" : each.value.eviction_soft_grace_period,
      "imagefs.available" : each.value.eviction_soft_grace_period,
      "imagefs.inodesFree" = each.value.eviction_soft_grace_period,
    }
    system_reserved = {
      "cpu"               = each.value.system_reserved_cpu
      "memory"            = each.value.system_reserved_memory
      "ephemeral-storage" = each.value.system_reserved_storage
    }
    kube_reserved = {
      "cpu"    = each.value.kube_reserved_cpu
      "memory" = each.value.kube_reserved_memory
    }
    max_pods = each.value.max_pods_per_node
  }
}
