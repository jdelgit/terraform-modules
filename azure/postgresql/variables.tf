variable "postgresql_server_name" {
  default = "test-postgresql-server"
}

variable "resource_group_name" {
  default = "test-rg"
}

variable "tags" {
  default = {
    environment = "test"
    projectCode = "terraform-template"
    invoiceCode = "tf-test"
  }
}

variable "resource_group_location" {
  default = "westeurope"
}

variable "postgresql_server_private_endpoint_name" {
  default = "postgresql-private-endpoint"
}

variable "database_admin_user" {
  default = "postgres"
}

variable "database_admin_password" {
  default = "Kt8AQfeLj8BEYFaUHkdG6us"
}

variable "vm_subnet_id" {
  default = "test-vm-subnet"
}

variable "database_version" {
  default = "11"
}

variable "sku_name" {
  default = "GP_Gen5_2"
}

variable "backup_retention_days" {
  default = 7
}

variable "auto_grow_enabled" {
  default = true
}

variable "public_network_access_enabled" {
  default = false
}

variable "ssl_minimal_tls_version_enforced" {
  default = "TLS1_2"
}

variable "ssl_enforcement_enabled" {
  default = true
}

variable "database_storage_mb" {
  default = 204800
}
