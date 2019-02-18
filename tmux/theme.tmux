# set colours and size
set -g status-bg colour233
set -g status-fg colour238
set -g status-left-length 72
set -g status-right-length 144

# status bar
set -g status-interval 15
set -g status-left '#[bg=colour000,fg=colour242] #S #[bg=colour233,fg=colour000]#[default] '
set -g status-right '#(~/.tmux/segments/machine_status) #(~/.tmux/segments/battery_status)#(~/.tmux/segments/lan_ip)#[fg=colour213,bg=colour000] %H:%M'
setw -g window-status-format '#[bg=colour233,fg=colour238] #I #[fg=colour244]#W#[default]  '
setw -g window-status-current-format '#[bg=colour253,fg=colour233]#[bg=colour253,fg=colour000] #W #[bg=colour233,fg=colour253]#[default]'

# pane borders
set -g pane-border-fg 'colour235'
set -g pane-active-border-fg 'colour238'

# windows
set -g window-status-separator ''
