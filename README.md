## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | 1.227.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.227.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_cs_kubernetes_node_pool.default](https://registry.terraform.io/providers/aliyun/alicloud/1.227.1/docs/resources/cs_kubernetes_node_pool) | resource |
| [alicloud_cs_managed_kubernetes.k8s](https://registry.terraform.io/providers/aliyun/alicloud/1.227.1/docs/resources/cs_managed_kubernetes) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_spec"></a> [cluster\_spec](#input\_cluster\_spec) | The specification of the managed Kubernetes cluster | `string` | n/a | yes |
| <a name="input_control_plane_vswitch_ids"></a> [control\_plane\_vswitch\_ids](#input\_control\_plane\_vswitch\_ids) | The IDs of the VSwitches for worker nodes | `list(string)` | n/a | yes |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | Whether to enable deletion protection for the Kubernetes cluster | `bool` | `true` | no |
| <a name="input_enable_datapath_v2"></a> [enable\_datapath\_v2](#input\_enable\_datapath\_v2) | Whether to enable the datapath V2 for the Kubernetes cluster | `bool` | `true` | no |
| <a name="input_enable_maintenance_window"></a> [enable\_maintenance\_window](#input\_enable\_maintenance\_window) | Whether to enable the maintenance window for the Kubernetes cluster | `bool` | `true` | no |
| <a name="input_enable_network_policy"></a> [enable\_network\_policy](#input\_enable\_network\_policy) | Whether to enable the datapath V2 for the Kubernetes cluster | `bool` | `true` | no |
| <a name="input_enabled_internet_access"></a> [enabled\_internet\_access](#input\_enabled\_internet\_access) | Whether to enable internet access for the Kubernetes cluster | `bool` | `false` | no |
| <a name="input_label_environment"></a> [label\_environment](#input\_label\_environment) | The environment label for the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_label_team"></a> [label\_team](#input\_label\_team) | The team label for the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_maintenance_window_duration"></a> [maintenance\_window\_duration](#input\_maintenance\_window\_duration) | The duration of the maintenance window for the Kubernetes cluster | `string` | `"3h"` | no |
| <a name="input_maintenance_window_time"></a> [maintenance\_window\_time](#input\_maintenance\_window\_time) | The time of the maintenance window for the Kubernetes cluster | `string` | `"17:00:00Z"` | no |
| <a name="input_maintenance_window_weekly_period"></a> [maintenance\_window\_weekly\_period](#input\_maintenance\_window\_weekly\_period) | The weekly period of the maintenance window for the Kubernetes cluster | `string` | `"Monday,Tuesday,Wednesday,Thursday"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the managed Kubernetes cluster | `string` | n/a | yes |
| <a name="input_node_cidr_mask"></a> [node\_cidr\_mask](#input\_node\_cidr\_mask) | The CIDR mask for the Kubernetes nodes | `number` | n/a | yes |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | The node pools for the Kubernetes cluster | <pre>map(object({<br>    node_pool_vswitch_ids = list(string)<br>    instance_type_ids     = list(string)<br>    system_disk_category  = string<br>    system_disk_size      = number<br>    key_name              = string<br>    image_type            = string<br>    multi_az_policy       = string<br><br>    taints = map(object({<br>      key    = string<br>      value  = string<br>      effect = string<br>    }))<br>    labels = map(object({<br>      key   = string<br>      value = string<br>    }))<br><br>    enable_auto_scaling        = bool<br>    min_size                   = number<br>    max_size                   = number<br>    eviction_soft_memory       = string<br>    eviction_soft_grace_period = string<br>    system_reserved_cpu        = string<br>    system_reserved_memory     = string<br>    system_reserved_storage    = string<br>    kube_reserved_cpu          = string<br>    kube_reserved_memory       = string<br>    max_pods_per_node          = number<br><br>  }))</pre> | n/a | yes |
| <a name="input_pod_vswitch_ids"></a> [pod\_vswitch\_ids](#input\_pod\_vswitch\_ids) | The CIDRs of the VSwitches for worker nodes | `list(string)` | n/a | yes |
| <a name="input_proxy_mode"></a> [proxy\_mode](#input\_proxy\_mode) | The proxy mode for the Kubernetes cluster | `string` | `"ipvs"` | no |
| <a name="input_service_cidr"></a> [service\_cidr](#input\_service\_cidr) | The CIDR block for the Kubernetes service | `string` | n/a | yes |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | The timezone for the Kubernetes cluster | `string` | `"Asia/Jakarta"` | no |

## Outputs

No outputs.
