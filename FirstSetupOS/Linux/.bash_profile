# prompt
export PS1="\[\e[0;36m\]\u@\h\[\e[0m\]:\[\e[0;94m\]\w\[\e[0m\]\$\n->"
if [[ $TERM == xterm* ]]; then
title='\h'
export PS1+="\[\e]0;$title\007\]"
fi

# Init env
export LANG=en_US.UTF-8
export EDITOR=vim

# Tmux colors
alias tmux="TERM=screen-256color-bce tmux"

# In case NPM lokal install
# NPM_PACKAGES=/users/ddrozdov/tools/node_install
# NODE_PATH=$NPM_PACKAGES/lib:$NODE_PATH
# PATH=$NPM_PACKAGES/bin:$PATH
# unset MANPATH
# MANPATH=$NPM_PACKAGES/share/man:$(manpath)

# TODO: optional path to zsh ()
# [ -f /bin/zsh ] && exec /bin/zsh -l

# Starship
# Install: https://starship.rs/guide/
eval "$(starship init bash)"
