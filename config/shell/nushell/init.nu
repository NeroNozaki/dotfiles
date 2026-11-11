# wow
export-env {
  $env.STARSHIP_CONFIG = ($nu.home-dir | path join "dotfiles" "config" "starship" "starship.toml")
}
# mkdir ($nu.data-dir | path join "vendor/autoload")
# starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
$env.config.buffer_editor = "nvim"
$env.config.shell_integration.osc133 = false

source "functions.nu"
source "aliases.nu"
source "env.nu"
# source "prompt.nu"
