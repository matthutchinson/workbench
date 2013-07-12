# theme
set -g status-bg black
set -g status-fg white
set -g status-left-length 30
set -g status-right-length 120
set -g status-left '#[fg=green]#h#[default]'

# ⮆⮆⮆ b6
# ⮇⮇⮇⮇ b7
# ⮈⮈⮈⮈  b8
# ⮉⮉⮉
# ⮂⮂⮂

# status bar
set -g status-interval 10
set -g status-right '#[bg=colour000,fg=colour255]⮉#[fg=colour000,bg=colour255] #(tmux-lan-ip-address) #[bg=colour255,fg=colour000]⮉#[bg=colour000,fg=colour235] | #(tmux-machine-stats)#(tmux-battery-mac) #[fg=colour235]| #(tmux-inbox-count)#[fg=colour198]%H:%M#[default]'
setw -g window-status-format '#[fg=colour235]#I #[fg=white]#W#[default]  '
setw -g window-status-current-format '#[bg=colour255,fg=colour000]⮀#[bg=colour255,fg=colour000] #W #[bg=colour000,fg=colour255]⮀'
