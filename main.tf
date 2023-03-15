module "terraform-cloud" {
  source = "./modules/tfc"
  yaml_config_file = "${path.cwd}/terraform-config.yaml"
}