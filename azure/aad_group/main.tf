resource "azuread_group" "group" {
  for_each                = { for group_data in var.groups_data : group_data.name => group_data }
  display_name            = each.value.name
  description             = each.value.description
  mail_enabled            = each.value.mail_enabled
  mail_nickname           = each.value.name
  security_enabled        = each.value.security_enabled
  types                   = each.value.types
  prevent_duplicate_names = true

  dynamic "dynamic_membership" {
    for_each = each.value.dynamic_membership_enabled ? [1] : []
    content {
      enabled = each.value.dynamic_membership_enabled
      rule    = each.value.dynamic_membership_rule
    }
  }

  owners  = each.value.owners
  members = each.value.members
}
