#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias autoremove='paru -c --noconfirm && paru -Scc'

PS1='[\u@\h \W]\$ '

eval "$(starship init bash)"

export PATH=/home/cln/.cargo/bin:$PATH

export PATH=/opt/flutter/bin:$PATH

export PATH=/home/cln/.local/summer-gruv-theme:$PATH
