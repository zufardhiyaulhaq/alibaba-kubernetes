variable "name" {
  type        = string
  description = "The name of the managed Kubernetes cluster"
}

variable "cluster_spec" {
  type        = string
  description = "The specification of the managed Kubernetes cluster"
  validation {
    condition = contains([
      "ack.standard",
      "ack.pro.small",
    ], var.cluster_spec)
    error_message = "You must provide appropriate cluster_spec. Available options: (ack.pro.small, ack.standard)."
  }
}

variable "control_plane_vswitch_ids" {
  type        = list(string)
  description = "The IDs of the VSwitches for worker nodes"
}

variable "pod_vswitch_ids" {
  type        = list(string)
  description = "The CIDRs of the VSwitches for worker nodes"
}

variable "node_cidr_mask" {
  type        = number
  description = "The CIDR mask for the Kubernetes nodes"
}

variable "proxy_mode" {
  type        = string
  description = "The proxy mode for the Kubernetes cluster"
  default     = "ipvs"
  validation {
    condition = contains([
      "ipvs",
      "iptables",
    ], var.proxy_mode)
    error_message = "You must provide appropriate proxy_mode. Available options: (ipvs, iptables)."
  }
}

variable "service_cidr" {
  type        = string
  description = "The CIDR block for the Kubernetes service"
}

variable "enabled_internet_access" {
  type        = bool
  description = "Whether to enable internet access for the Kubernetes cluster"
  default     = false
}

variable "deletion_protection" {
  type        = bool
  description = "Whether to enable deletion protection for the Kubernetes cluster"
  default     = true
}

variable "timezone" {
  type        = string
  description = "The timezone for the Kubernetes cluster"
  default     = "Asia/Jakarta"
}

variable "enable_maintenance_window" {
  type        = bool
  description = "Whether to enable the maintenance window for the Kubernetes cluster"
  default     = true
}

variable "maintenance_window_time" {
  type        = string
  description = "The time of the maintenance window for the Kubernetes cluster"
  default     = "17:00:00Z"
}

variable "maintenance_window_duration" {
  type        = string
  description = "The duration of the maintenance window for the Kubernetes cluster"
  default     = "3h"
}

variable "maintenance_window_weekly_period" {
  type        = string
  description = "The weekly period of the maintenance window for the Kubernetes cluster"
  default     = "Monday,Tuesday,Wednesday,Thursday"
}

variable "label_team" {
  type        = string
  description = "The team label for the Kubernetes cluster"
}

variable "label_environment" {
  type        = string
  description = "The environment label for the Kubernetes cluster"
}

variable "enable_datapath_v2" {
  type        = bool
  description = "Whether to enable the datapath V2 for the Kubernetes cluster"
  default     = true
}

variable "enable_network_policy" {
  type        = bool
  description = "Whether to enable the datapath V2 for the Kubernetes cluster"
  default     = true
}

variable "node_pools" {
  type = map(object({
    node_pool_vswitch_ids = list(string)
    instance_type_ids     = list(string)
    system_disk_category  = string
    system_disk_size      = number
    key_name              = string
    image_type            = string
    multi_az_policy       = string

    taints = map(object({
      key    = string
      value  = string
      effect = string
    }))
    labels = map(object({
      key   = string
      value = string
    }))

    enable_auto_scaling        = bool
    min_size                   = number
    max_size                   = number
    eviction_soft_memory       = string
    eviction_soft_grace_period = string
    system_reserved_cpu        = string
    system_reserved_memory     = string
    system_reserved_storage    = string
    kube_reserved_cpu          = string
    kube_reserved_memory       = string
    max_pods_per_node          = number

  }))
  description = "The node pools for the Kubernetes cluster"
}