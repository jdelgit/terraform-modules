variable "storageaccount_name" {
  default = "testblobstorageterraform"
}

variable "storage_account_kind" {
  default = "StorageV2"
}

variable "storage_account_tier" {
  default = "Standard"
}

variable "storage_account_replication_type" {
  default = "LRS"
}


variable "resource_group_name" {
  default = "test-rg"
}

variable "resource_group_location" {
  default = "West Europe"
}

variable "tags" {
  default = {
    environment = "test"
    projectCode = "terraform-template"
    invoiceCode = "tf-test"
  }
}

variable "storage_allowed_ips" {
  default = []
}

variable "storage_default_action" {
  default = "Deny"
}

variable "subnet_id" {
  default = ""
}

variable "storage_private_endpoint_name" {
  default = "storage-private-endpoint"
}

variable "private_service_connection_name" {
  default = "storage-private-endpoint-svc"
}


