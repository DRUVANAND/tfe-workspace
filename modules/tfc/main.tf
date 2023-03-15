locals {
  config = yamldecode(file(var.yaml_config_file))
  org_name = local.config.org
}

resource "tfe_workspace" "workspace" {
  for_each     = { for ws in local.config.workspaces : ws.name => ws }
  name         = each.value.name
  organization = local.org_name
  description  = each.value.description

  tag_names = each.value.tags
}

resource "tfe_team" "team" {
  for_each     = { for t in local.config.teams : t.name => t }
  name         = each.value.name
  organization = local.org_name
}

resource "tfe_team_members" "team_members" {
  for_each  = { for t in local.config.teams : t.name => t }
  team_id   = tfe_team.team[each.value.name].id
  usernames = [for user in each.value.users : user]
}

resource "tfe_team_access" "team_access" {
  for_each     = { for t in local.config.permissions : t.team => t if can(t.access) }
  access       = each.value.access
  team_id      = tfe_team.team[each.value.team].id
  workspace_id = tfe_workspace.workspace[each.value.workspace].id
}

resource "tfe_team_access" "team_permissions" {
  for_each = { for t in local.config.permissions : t.team => t if can(t.permissions) }
  permissions {
    runs              = each.value.permissions.runs
    variables         = each.value.permissions.variables
    state_versions    = each.value.permissions.state_versions
    sentinel_mocks    = each.value.permissions.sentinel_mocks
    workspace_locking = each.value.permissions.workspace_locking
    run_tasks         = each.value.permissions.run_tasks
  }
  team_id      = tfe_team.team[each.value.team].id
  workspace_id = tfe_workspace.workspace[each.value.workspace].id
}
