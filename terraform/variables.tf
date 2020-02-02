variable "location" {
    default = "northeurope"
}

variable "tags" {
    type = "map"
    default = {
        environment = "dev"
        source      = "terraform"
    }   
}

variable "vn_cidr" {
    type = "list" 
    default = ["10.0.0.0/16"]
}


variable "client_id" {}
variable "client_secret" {}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable resource_group_name {
    default = "azure-functions"
}

variable log_analytics_workspace_name {
    default = "testLogAnalyticsWorkspaceName"
}

# refer https://azure.microsoft.com/global-infrastructure/services/?products=monitor for log analytics available regions
variable log_analytics_workspace_location {
    default = "eastus"
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 
variable log_analytics_workspace_sku {
    default = "PerGB2018"
}