# TFC
- terraform-config.yaml defines the workspace, team, and permission configuration.
- Uses the yamldecode() function to convert the YAML contents into a map that can be passed to other Terraform resources.

# PREREQUISITES
- Update `org` in tfc/terraform-config.yaml
- Export terraform cloud api token
```
export TFE_TOKEN=XXXXX
```

# STEPS
```
terraform init
```
```
terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.terraform-cloud.tfe_team.team["Platform-TGD-Employees-Access"] will be created
  + resource "tfe_team" "team" {
      + id           = (known after apply)
      + name         = "Platform-TGD-Employees-Access"
      + organization = "soorg"
      + visibility   = "secret"

      + organization_access {
          + manage_modules          = (known after apply)
          + manage_policies         = (known after apply)
          + manage_policy_overrides = (known after apply)
          + manage_projects         = (known after apply)
          + manage_providers        = (known after apply)
          + manage_run_tasks        = (known after apply)
          + manage_vcs_settings     = (known after apply)
          + manage_workspaces       = (known after apply)
        }
    }

  # module.terraform-cloud.tfe_team.team["Platform-TGD-Employees-Permission"] will be created
  + resource "tfe_team" "team" {
      + id           = (known after apply)
      + name         = "Platform-TGD-Employees-Permission"
      + organization = "soorg"
      + visibility   = "secret"

      + organization_access {
          + manage_modules          = (known after apply)
          + manage_policies         = (known after apply)
          + manage_policy_overrides = (known after apply)
          + manage_projects         = (known after apply)
          + manage_providers        = (known after apply)
          + manage_run_tasks        = (known after apply)
          + manage_vcs_settings     = (known after apply)
          + manage_workspaces       = (known after apply)
        }
    }

  # module.terraform-cloud.tfe_team_access.team_access["Platform-TGD-Employees-Access"] will be created
  + resource "tfe_team_access" "team_access" {
      + access       = "admin"
      + id           = (known after apply)
      + team_id      = (known after apply)
      + workspace_id = (known after apply)

      + permissions {
          + run_tasks         = (known after apply)
          + runs              = (known after apply)
          + sentinel_mocks    = (known after apply)
          + state_versions    = (known after apply)
          + variables         = (known after apply)
          + workspace_locking = (known after apply)
        }
    }

  # module.terraform-cloud.tfe_team_access.team_permissions["Platform-TGD-Employees-Permission"] will be created
  + resource "tfe_team_access" "team_permissions" {
      + access       = "custom"
      + id           = (known after apply)
      + team_id      = (known after apply)
      + workspace_id = (known after apply)

      + permissions {
          + run_tasks         = true
          + runs              = "apply"
          + sentinel_mocks    = "none"
          + state_versions    = "read-outputs"
          + variables         = "read"
          + workspace_locking = false
        }
    }

  # module.terraform-cloud.tfe_team_members.team_members["Platform-TGD-Employees-Access"] will be created
  + resource "tfe_team_members" "team_members" {
      + id        = (known after apply)
      + team_id   = (known after apply)
      + usernames = [
          + "user1",
          + "user2",
          + "user3",
        ]
    }

  # module.terraform-cloud.tfe_team_members.team_members["Platform-TGD-Employees-Permission"] will be created
  + resource "tfe_team_members" "team_members" {
      + id        = (known after apply)
      + team_id   = (known after apply)
      + usernames = [
          + "user4",
        ]
    }

  # module.terraform-cloud.tfe_workspace.workspace["tardigrades-dev"] will be created
  + resource "tfe_workspace" "workspace" {
      + allow_destroy_plan            = true
      + auto_apply                    = false
      + description                   = "Dev workspace for tardigrades dev"
      + execution_mode                = "remote"
      + file_triggers_enabled         = true
      + force_delete                  = false
      + global_remote_state           = (known after apply)
      + id                            = (known after apply)
      + name                          = "tardigrades-dev"
      + operations                    = (known after apply)
      + organization                  = "soorg"
      + project_id                    = (known after apply)
      + queue_all_runs                = true
      + remote_state_consumer_ids     = (known after apply)
      + resource_count                = (known after apply)
      + speculative_enabled           = true
      + structured_run_output_enabled = true
      + tag_names                     = [
          + "aws",
          + "dev",
          + "eks",
        ]
      + terraform_version             = (known after apply)
    }

Plan: 7 to add, 0 to change, 0 to destroy.
```

```
terraform apply
```