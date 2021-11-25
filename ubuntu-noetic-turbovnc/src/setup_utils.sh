#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "setup user bash tools"


su ${MY_USER}
# Optimize bashrc
sed -i 's/HISTSIZE=1000/HISTSIZE=20000/g' ~/.bashrc  && \
sed -i 's/HISTFILESIZE=2000/HISTFILESIZE=40000/g' ~/.bashrc


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
set -g default-terminal \"screen-256color\"" >> ~/.tmux.conf
