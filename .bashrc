#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

EDITOR=vim

[ -e /usr/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh ] && source /usr/lib/python3.5/site-packages/powerline/bindings/bash/powerline.sh

alias irc='ssh weechat@clearlyreta.rded.nl -t tmux a'

export PATH="$HOME/.gem/ruby/2.3.0/bin:$PATH"
