#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "install bash tools"

apt-get install -y     \
      openssh-server   \
      cmake            \
      vim              \
      wget             \
      tmux             \
      rsync            \
      curl             \
      git              \
      gnupg2


# Allow root user to login over ssh on port 2222
sed -ri 's/^#?Port\s+.*/Port 2222/' /etc/ssh/sshd_config



cd ${MY_HOME}



echo "set -g mouse on
set-option -g history-limit 100000
# remap prefix from 'C-b' to 'C-a'
# unbind C-b
# set-option -g prefix C-a
# bind-key C-a send-prefix
# switch panes using Alt-arrow without prefix
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D
# switch colour
set -g default-terminal \"screen-256color\"" >> ${MY_HOME}/.tmux.conf

chown -R ${MY_USER}:${MY_USER} ${MY_HOME}
