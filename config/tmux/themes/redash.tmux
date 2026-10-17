#!/usr/bin/env bash

# Red Ash colors for Tmux

set -g mode-style "fg=#E6B800,bg=#333333"

set -g message-style "fg=#E6B800,bg=#333333"
set -g message-command-style "fg=#E6B800,bg=#333333"

set -g pane-border-style "fg=#484848"
set -g pane-active-border-style "fg=#df5b61"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#D4D4D4,bg=#000000"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#000000,bg=#df5b61,bold] #S #[fg=#df5b61,bg=#000000,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#262626,bg=#000000,nobold,nounderscore,noitalics]#[fg=#D4D4D4,bg=#262626] #{prefix_highlight} #[fg=#484848,bg=#262626,nobold,nounderscore,noitalics]#[fg=#D4D4D4,bg=#484848] %Y-%m-%d  %H:%M #[fg=#484848,bg=#484848,nobold,nounderscore,noitalics]#[fg=#000000,bg=#df5b61,bold] #h "

if-shell '[ "$(tmux show-option -gqv "clock-mode-style")" == "12" ]' {
  set -g status-right "#[fg=#262626,bg=#000000,nobold,nounderscore,noitalics]#[fg=#D4D4D4,bg=#262626] #{prefix_highlight} #[fg=#484848,bg=#262626,nobold,nounderscore,noitalics]#[fg=#D4D4D4,bg=#484848] %Y-%m-%d  %I:%M %p #[fg=#484848,bg=#484848,nobold,nounderscore,noitalics]#[fg=#000000,bg=#df5b61,bold] #h "
}

setw -g window-status-activity-style "underscore,fg=#929292,bg=#000000"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#929292,bg=#000000"
setw -g window-status-format "#[fg=#000000,bg=#000000,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#000000,bg=#000000,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#000000,bg=#262626,nobold,nounderscore,noitalics]#[fg=#df5b61,bg=#262626,bold] #I  #W #F #[fg=#262626,bg=#000000,nobold,nounderscore,noitalics]"

# tmux-plugins/tmux-prefix-highlight support
set -g @prefix_highlight_output_prefix "#[fg=#E6B800]#[bg=#000000]#[fg=#000000]#[bg=#E6B800]"
set -g @prefix_highlight_output_suffix ""
