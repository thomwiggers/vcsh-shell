#!/bin/zsh

# settings
setopt NO_BG_NICE
setopt NO_HUP
setopt NO_LIST_BEEP
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt MULTIBYTE
setopt COMBINING_CHARS
setopt COMPLETE_ALIASES

# emacs mode
bindkey -e

# Home/End/Delete
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line 
bindkey '\e[3~' delete-char

# ctrl-backspace/delete
bindkey "\C-_" backward-kill-word
bindkey "\e[3;5~" kill-word

# ctrl-left/right
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word

# Editor
export EDITOR=vim

# Path: add ruby
export PATH="$HOME/.gem/ruby/2.3.0/bin:$PATH"

# SSH Agent with Systemd
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# Dirstack
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
DIRSTACKSIZE=20
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

setopt autopushd pushdsilent pushdtohome
setopt pushdignoredups
setopt pushdminus


if [[ "$COLORTERM" == "gnome-terminal" ]]; then
    export TERM=xterm-256color
fi

autoload -U compinit

if [ -e "/usr/bin/virtualenvwrapper_lazy.sh" ]; then
    export WORKON_HOME="$HOME/.pythonenvs"
    source "/usr/bin/virtualenvwrapper_lazy.sh"
fi

if [ -e /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -e "$HOME/.dircolors" ]; then
    eval $(dircolors "$HOME/.dircolors")
fi

if [ -e /usr/share/zsh/site-contrib/powerline.zsh ]; then
    source /usr/share/zsh/site-contrib/powerline.zsh
fi

if $(which hub > /dev/null); then
    eval $(hub alias -s);
fi

alias ls='ls --color=auto --quoting-style=literal'
alias ll='ls -l --human-readable'
alias la='ls -l --almost-all --human-readable'
alias cp='cp --reflink=auto '
alias irc='ssh irc -t tmux a'
alias mirc='mosh irc tmux a'
alias clm='$HOME/clean/bin/clm'
alias graderand="cd ./\$(grep -lr 'Needs Grading' | sort -R | cut -d'/' -f1 | head -1)"
