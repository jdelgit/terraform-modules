output group_ids {
 description = "Contains a list of the the resource id of the groups"
  value       = { for group in azuread_group.group : group.display_name => group.id }
}