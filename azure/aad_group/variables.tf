variable "groups_data" {
  description = "Groups to be created along with their configurationss"
  type = list(object({
    name                       = string
    description                = string
    owners                     = list(string)
    members                    = list(string)
    security_enabled           = bool
    mail_enabled               = bool
    types                      = list(string)
    assignable_to_role         = bool
    dynamic_membership_enabled = bool
    dynamic_membership_rule    = string
  }))
}
