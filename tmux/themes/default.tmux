# set colours and size
set -g status-bg colour233
set -g status-fg colour238
set -g status-left-length 72
set -g status-right-length 144

# pane borders
set -g pane-border-style 'fg=colour235'
set -g pane-active-border-style 'fg=colour238'

# status
set -g status on
set -g status-interval 5
set -g status-justify "centre"
set -g status-left '#[bg=colour000,fg=colour242] #S #[default]#[bg=colour233,fg=colour000]'
set -g status-right '#(~/.tmux/segments/combined)'

# window status
setw -g window-status-separator ''
setw -g window-status-format '#[bg=colour233,fg=colour233]#[bg=colour233,fg=colour238] #I #[fg=colour244]#W #[bg=colour233,fg=colour233]#[default]'
setw -g window-status-current-format '#[bg=colour253,fg=colour233]#[bg=colour253,fg=colour000]  #W #[bg=colour233,fg=colour253]#[default]'
