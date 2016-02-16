#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# Wrap git automatically by adding the following to ~/.bash_profile:
if $(which hub > /dev/null); then
    eval "$(hub alias -s)"
fi
