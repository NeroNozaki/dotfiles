# prompt.nu
#
# Native Nushell replacement for the active parts of my Starship config.
# Target: Nushell 0.117+ on Windows.

# ------------------------------------------------------------
# Colors
# ------------------------------------------------------------

const C_BLUE = "#82aaff"
const C_PURPLE = "#bb9af7"
const C_GREEN = "#00ff00"
const C_RED = "#ff5555"
const C_YELLOW = "#e0af68"
const C_TIME_FG = "#a0a9cb"
const C_TIME_BG = "#1d2230"

# ------------------------------------------------------------
# Operating system
# ------------------------------------------------------------

def prompt_os [] {
    $"(ansi white_bold)󰍲 (ansi reset)"
}

# ------------------------------------------------------------
# Directory
# ------------------------------------------------------------

def prompt_directory [] {
    let current = (pwd)

    let relative = (do -i {
        $current | path relative-to $nu.home-dir
    })

    let display = if $relative == null {
        $current
    } else if ($relative | is-empty) {
        "~"
    } else {
        "~" | path join $relative
    }

    let segments = (
        $display
        | path split
        | each {|part|
            match $part {
                "Documents" => "󰈙 "
                "Downloads" => " "
                "Music" => " "
                "Pictures" => " "
                _ => $part
            }
        }
    )

    let rendered = ($segments | str join (char path_sep))

    $"(ansi { fg: '#82aaff' })($rendered)(ansi reset) "
}

# ------------------------------------------------------------
# Git
# ------------------------------------------------------------

def prompt_git [] {
    let result = (
        do -i {
            ^git status --porcelain=v2 --branch --show-stash
        } | complete
    )

    if $result.exit_code != 0 {
        return ""
    }

    let lines = ($result.stdout | lines)

    # Branch information.
    let branch_line = (
        $lines
        | where {|line| $line | str starts-with "# branch.head " }
        | first
        | default ""
    )

    let branch = ($branch_line | str replace "# branch.head " "")

    let upstream_line = (
        $lines
        | where {|line| $line | str starts-with "# branch.upstream " }
        | first
        | default ""
    )

    let upstream = (
        $upstream_line
        | str replace "# branch.upstream " ""
    )

    let oid_line = (
        $lines
        | where {|line| $line | str starts-with "# branch.oid " }
        | first
        | default ""
    )

    let oid = ($oid_line | str replace "# branch.oid " "")

    let branch_segment = if $branch == "" or $branch == "(detached)" {
      ""
    } else {
      $"on (ansi purple_bold) ($branch)(ansi reset) "
    }

    let commit_segment = if $branch == "(detached)" {
        let short = ($oid | str substring 0..6)
        $"(ansi green_bold)(($short))(ansi reset) "
    } else {
        ""
    }

    # Working tree status.
    let entries = (
        $lines
        | where {|line| not ($line | str starts-with "#") }
    )

    let statuses = (
        $entries
        | each {|line|
            if ($line | str starts-with "? ") {
                "??"
            } else {
                $line | split row " " | get 1
            }
        }
    )

    let conflicted = (
      $statuses
      | any {|xy|
        ($xy | str contains "U") or ($xy == "AA") or ($xy == "DD")
      }
    )

    let deleted = (
        $statuses
        | any {|xy| ($xy | str contains "D") }
    )

    let renamed = (
        $statuses
        | any {|xy| ($xy | str contains "R") }
    )

    let modified = (
        $statuses
        | any {|xy| ($xy | str substring 1..1) == "M" }
    )

    let staged = (
        $statuses
        | any {|xy|
            ($xy | str substring 0..0) in ["M" "A" "D" "R" "C"]
        }
    )

    let untracked = ($statuses | any {|xy| $xy == "??" })

    let stash_line = (
        $lines
        | where {|line| $line | str starts-with "# stash " }
        | first
        | default ""
    )

    let has_stash = $stash_line != "" and (
        ($stash_line | str replace "# stash " "" | into int) > 0
    )

    # Ahead / behind.
    let ab_line = (
        $lines
        | where {|line| $line | str starts-with "# branch.ab " }
        | first
        | default ""
    )

    let ahead_behind = if $ab_line == "" {
        ""
    } else {
        let parts = ($ab_line | split row " ")
        let ahead = ($parts | get 2 | str replace "+" "" | into int)
        let behind = ($parts | get 3 | str replace "-" "" | into int)

        if $ahead > 0 and $behind > 0 {
            "⇕"
        } else if $ahead > 0 {
            "⇡"
        } else if $behind > 0 {
            "⇣"
        } else {
            ""
        }
    }

    # Git operation state.
    let git_dir_result = (
        do -i {
            ^git rev-parse --absolute-git-dir
        } | complete
    )

    let state = if $git_dir_result.exit_code != 0 {
        ""
    } else {
        let dir = ($git_dir_result.stdout | str trim)

        if ($dir | path join "rebase-merge" | path exists) {
            "REBASING"
        } else if ($dir | path join "rebase-apply" | path exists) {
            "AM/REBASE"
        } else if ($dir | path join "MERGE_HEAD" | path exists) {
            "MERGING"
        } else if ($dir | path join "REVERT_HEAD" | path exists) {
            "REVERTING"
        } else if ($dir | path join "CHERRY_PICK_HEAD" | path exists) {
            "CHERRY-PICKING"
        } else if ($dir | path join "BISECT_LOG" | path exists) {
            "BISECTING"
        } else {
            ""
        }
    }

    let state_segment = if $state == "" {
      ""
    } else {
      $"(ansi yellow_bold)[($state)](ansi reset) "
    }

    # Assemble status symbols in Starship's order.
    let symbols = [
        (if $conflicted { "=" } else { "" })
        (if $deleted { "✘" } else { "" })
        (if $renamed { "»" } else { "" })
        (if $modified { "!" } else { "" })
        (if $staged { "+" } else { "" })
        (if $untracked { "?" } else { "" })
        (if $has_stash { "$" } else { "" })
        $ahead_behind
    ] | str join

    let status_segment = if $symbols == "" {
      ""
    } else {
      $"(ansi red_bold)[($symbols)](ansi reset) "
    }

    [
        $branch_segment
        $commit_segment
        $state_segment
        $status_segment
    ] | str join
}

# ------------------------------------------------------------
# Battery (Windows)
# ------------------------------------------------------------

def prompt_battery [] {
    let result = (
        do -i {
            ^powershell.exe -NoProfile -NonInteractive -Command '$b = Get-CimInstance -ClassName Win32_Battery | Select-Object -First 1; if ($null -ne $b) { "{0}|{1}" -f $b.BatteryStatus, $b.EstimatedChargeRemaining }'
        } | complete
    )

    if $result.exit_code != 0 or ($result.stdout | str trim | is-empty) {
        return ""
    }

    let values = ($result.stdout | str trim | split row "|")
    let battery_status = ($values | get 0 | into int)
    let percentage = ($values | get 1 | into int)

    let symbol = match $battery_status {
        2 | 6 | 7 | 8 | 9 => "󰂄 "
        1 => "󰂃 "
        3 => "󰁹 "
        4 => "󰂎 "
        5 => "󰂎 "
        _ => "󰁽 "
    }

    $"(ansi red_bold)($symbol)($percentage)%(ansi reset) "
}

# ------------------------------------------------------------
# Time
# ------------------------------------------------------------

def prompt_time [] {
    let time = (date now | format date "%R")

    let start = "\u{1b}[38;2;160;169;203;48;2;29;34;48m"

    [
        $start
        "  "
        $time
        " "
        (ansi reset)
    ] | str join
}

# ------------------------------------------------------------
# Prompt assembly
# ------------------------------------------------------------

def prompt_left [] {
    [
        (prompt_os)
        (prompt_git)
        (prompt_directory)
        "\n"
    ] | str join
}

def prompt_right [] {
    [
        (prompt_time)
        (prompt_battery)
    ] | str join
}

# ------------------------------------------------------------
# Nushell prompt configuration
# ------------------------------------------------------------

$env.PROMPT_COMMAND = {|| prompt_left }
$env.PROMPT_COMMAND_RIGHT = {|| prompt_right }

# Right prompt stays on the first line.
$env.config.render_right_prompt_on_last_line = false

# Character indicator.
$env.PROMPT_INDICATOR = $"(ansi green_bold)❯ (ansi reset)"
$env.PROMPT_INDICATOR_VI_INSERT = $"(ansi green_bold)❯ (ansi reset)"
$env.PROMPT_INDICATOR_VI_NORMAL = $"(ansi green_bold)❮ (ansi reset)"

$env.PROMPT_MULTILINE_INDICATOR = $"(ansi brblack)∙(ansi reset) "
