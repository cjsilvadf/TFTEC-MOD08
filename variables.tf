#############################
## Application - Variables ##
#############################
variable "company" {
  type = string
}
variable "prefix" {
  type = string
}
variable "location_eastus" {
  type    = string
}
variable "region" {
  type    = string
  default = "ne"
}
variable "owner" {
  type = string
}
variable "description" {
  type = string
}
variable "environment" {
  type = string
}
variable "app_name" {
  type = string
}
############################
## Windows VM - Variables ##
############################
# Windows VM Hostname (limited to 15 characters long)
variable "windows-vm-hostname" {
  type        = string
  description = "Windows VM Hostname"
}
# Windows VM Virtual Machine Size
variable "windows-vm-size" {
  type        = string
  description = "Windows VM Size"
}
variable "jumpbox-vm-size" {
  type        = string
  description = "Windows VM Size"
}
# Windows VM Admin User
variable "windows-admin-username" {
  type        = string
  description = "Windows VM Admin User"
}

# Windows VM Admin Password
variable "windows-admin-password" {
  type        = string
  description = "Windows VM Admin Password"
}

##############
## OS Image ##
##############

# Windows Server 2019 SKU used to build VMs
variable "windows-2019-sku" {
  type        = string
  description = "Windows Server 2019 SKU used to build VMs"
}

variable "tags" {
  type        = map(any)
  description = "Tags nos Recursos e Serviços do azure"
  default = {
    Envirement = "Treinamento"
  }
}
variable "application_port" {
  description = "Port that you want to expose to the external load balancer"
}

variable "scale_in_policy" {
  description = "The scale-in policy rule that decides which virtual machines are chosen for removal when a Virtual Machine Scale Set is scaled in. Possible values for the scale-in policy rules are `Default`, `NewestVM` and `OldestVM`" 
}
variable "nsg_name" {
  type = string
}
variable "lb_rule_name" {
  type = string
}
variable "lb_frontend_ip" {
  type = string
}

variable "notification_email" {
  type = string
  
}