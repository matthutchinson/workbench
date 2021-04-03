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
set -g status-left '#[bg=colour236,fg=colour007] #(~/.tmux/segments/hostname) #[bg=colour234,fg=colour236]#[fg=colour245] #S #[default]#[bg=colour233,fg=colour234]'
set -g status-right '#(~/.tmux/segments/combined)'

# window status
setw -g window-status-separator ''
setw -g window-status-format '#[bg=colour233,fg=colour233]#[bg=colour233,fg=colour238] #I #[fg=colour244]#W #[bg=colour233,fg=colour233]#[default]'
setw -g window-status-current-format '#[bg=colour250,fg=colour233]#[bg=colour250,fg=colour000]  #W #[bg=colour233,fg=colour250]#[default]'
