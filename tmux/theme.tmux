# set colours and size
set -g status-left-length 72
set -g status-right-length 144

set -g status-position bottom
set -g status-justify centre

# pane borders
# set -g pane-border-style "fg=#000000"
# set -g pane-active-border-style "fg=#000000"

set -g pane-border-style "fg=colour235"
set -g pane-active-border-style "fg=colour235"

# left and right status
set -g status on
set -g status-interval 5
set -g status-justify "centre"
set -g status-left "#[bg=colour236,fg=colour007] #H #[bg=colour234,fg=colour236]#[fg=colour245] #S #[default]#[bg=#111111,fg=colour234]"
set -g status-right "#(~/.tmux/segments/combined)#[fg=colour213,bg=colour016] %H:%M"

# center window status
set -g window-status-separator ""
set -g window-status-format "#[bg=#111111,fg=colour238] #I #[fg=colour244]#W  #[default]"
set -g window-status-current-format "#[bg=#111111,fg=colour008]#[bg=colour008,fg=colour255] #W #[bg=#111111,fg=colour008]#[default]"
set -g window-status-style "fg=#6b7089"
set -g window-status-separator ""
