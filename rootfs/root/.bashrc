# Display banner
if [ -f "/root/.banner" ]; then
   cat "/root/.banner"
fi

# Display build message
if [ -f "/root/.built" ]; then
   echo "========================================================================================================"
   cat "/root/.built"
   echo "========================================================================================================"
fi

export PS1="\[\e[32;1m\]\u@\w > \[\e[0m\]"

# Alias definitions.
#
alias df='df -h'
alias du='du -h'

alias ls='ls -p'
alias ll='ls -l'
alias la='ls -la'

# Avoid errors... use -f to skip confirmation.
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
