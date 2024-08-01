module "alibaba_kubernetes" {
  source = "../"

  name                             = "s-id-em-ack-01"
  cluster_spec                     = "ack.pro.small"
  control_plane_vswitch_ids        = ["vsw-k1arrxb8gaxm55zy4wxz5", "vsw-k1a7dmyavpandrxfirbb7", "vsw-k1a5gfxyja7nukhiwpjk6"]
  pod_vswitch_ids                  = ["vsw-k1a4i1hkfy290oze4aqjd", "vsw-k1a5h1teuds73x4n7kdpb", "vsw-k1avxmatvf71zgt8k4gnl"]
  node_cidr_mask                   = 24
  proxy_mode                       = "ipvs"
  service_cidr                     = "172.16.0.0/20"
  enable_datapath_v2               = true
  enable_maintenance_window        = true
  enable_network_policy            = true
  enabled_internet_access          = true
  deletion_protection              = true
  timezone                         = "Asia/Jakarta"
  maintenance_window_time          = "17:00:00Z"
  maintenance_window_duration      = "3h"
  maintenance_window_weekly_period = "Monday,Tuesday,Wednesday,Thursday"

  label_environment = "staging"
  label_team        = "coins"

  node_pools = {
    "nodepool-01" = {
      node_pool_vswitch_ids = ["vsw-k1arrxb8gaxm55zy4wxz5", "vsw-k1a7dmyavpandrxfirbb7", "vsw-k1a5gfxyja7nukhiwpjk6"]
      instance_type_ids     = ["ecs.c7a.xlarge", "ecs.c8i.xlarge"]
      system_disk_category  = "cloud_essd"
      system_disk_size      = 100
      key_name              = ""
      image_type            = "ContainerOS"
      multi_az_policy       = "COST_OPTIMIZED"

      taints = {}
      labels = {
        "01" = {
          key   = "team"
          value = "coins"
        }
        "02" = {
          key   = "environment"
          value = "staging"
        }
      }

      enable_auto_scaling        = true
      min_size                   = 1
      max_size                   = 6
      eviction_soft_memory       = "512Mi"
      eviction_soft_grace_period = "30s"
      system_reserved_cpu        = "256m"
      system_reserved_memory     = "512Mi"
      system_reserved_storage    = "2Gi"
      kube_reserved_cpu          = "256m"
      kube_reserved_memory       = "512Mi"
      max_pods_per_node          = 128
    }
  }
}