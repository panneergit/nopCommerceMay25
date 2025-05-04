variable "resource_group" {
    type = object({
      name = string
      location = string
    })
    description = "This is resource group"
}

variable "aks_cluster_info" {
    type = object({
      node_pool_name = string
      node_count = number
      vm_size = string
    })
    description = "This is azure kubernetes services"
}

variable "build_number" {
  type = string
  default = "0"
}
