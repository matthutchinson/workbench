# theme
set -g status-bg black
set -g status-fg white
set -g status-left-length 30
set -g status-right-length 120
set -g status-left '#[fg=green]#H#[default]'

# status bar
set -g status-interval 10
set -g status-right '#[fg=colour235]#(tmux-lan-ip-address) | #(tmux-machine-stats)#(tmux-battery-mac) #[fg=colour235]| #(tmux-inbox-count)#[fg=colour198]%H:%M#[default]'
setw -g window-status-format '#[fg=colour235]#I #[fg=white]#W#[default]  '
setw -g window-status-current-format '#[bg=white,fg=black]⮀#[bg=white,fg=black] #W #[bg=black,fg=white]⮀'
