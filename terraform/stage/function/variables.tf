variable "location" {
    default = "northeurope"
}

variable "tags" {
    type = map
    default = {
        environment = "dev"
        source      = "terraform"
    }   
}

variable resource_group_name {
    type = string
    description = "Resource group"
}

variable log_analytics_workspace_name {
    type = string
    description = "log analytics workpsace name"
    default = "testLogAnalyticsWorkspaceName"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "northeurope"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}