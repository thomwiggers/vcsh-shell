#!/bin/zsh

# settings
setopt AUTOCD
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

# Path: add ruby, ruby
export PATH="$HOME/.local/bin:$HOME/.gem/ruby/2.3.0/bin:$PATH"

# SSH Agent with Systemd
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

if [[ "$COLORTERM" == "gnome-terminal" ]]; then
    export TERM=xterm-256color
fi

# From http://dotfiles.org/~_why/.zshrc
# Sets the window title nicely no matter where you are
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen)
    print -Pn "\ek$a:$3\e\\" # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2:$3\a" # plain xterm title ($3 for pwd)
    ;;
  esac
}

function precmd {
    title "zsh" "%m" "%55<...<%~"
}

## Completion
autoload -U compinit
compinit
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# XZ threaded
XZ_OPTS="-T 8"


if [ -e "/usr/bin/virtualenvwrapper_lazy.sh" ]; then
    export WORKON_HOME="$HOME/.pythonenvs"
    source "/usr/bin/virtualenvwrapper_lazy.sh"
fi

# Colours

if [ -e /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -e "$HOME/.dircolors" ]; then
    eval $(dircolors "$HOME/.dircolors")
fi

if [ -e /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh ]; then
    source /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh
fi

## aliases

if $(which hub > /dev/null 2>&1); then
    eval $(hub alias -s);
fi

if $(which thefuck > /dev/null); then
    eval $(thefuck --alias);
fi

alias ls='ls --color=auto --quoting-style=literal'
alias ll='ls -l --human-readable'
alias la='ls -l --almost-all --human-readable'
alias l='ls'
alias sl='ls'
alias cp='cp --reflink=auto '
alias irc='ssh irc -t tmux a'
alias mirc='mosh irc tmux a'
alias clm='$HOME/clean/bin/clm -I $HOME/clean/lib/StdEnv/ -I $HOME/clean/lib/Dynamics/'
alias graderand="cd ./\$(grep -lr 'Needs Grading' s*/s*.txt | sort -R | cut -d'/' -f1 | head -1)"

package() {
    tar cvJf "$1.tar.xz" "$*"
}

pb() {
    echo "Pasting"
    curl -sF "c=@${1:--}" -w "%{redirect_url}" 'https://ptpb.pw/?r=1' -o /dev/stderr | xsel -l /dev/null -b
}

open() {
    xdg-open $@ 2> /dev/null & disown
}

# initialize completion
compinit
