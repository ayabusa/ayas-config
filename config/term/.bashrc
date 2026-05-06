# .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Colors goes brrrrrrr
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# Handy when writing some C
alias comp='gcc -Wall -Wextra -fsanitize=address -g'
alias push='git add -A && git commit && git push'

# Void specifics
alias psearch='xbps-query -Rs'
alias pinst='sudo xbps-install -u'

# Prompt
PROMPT_COMMAND='PS1_CMD1=$(git branch --show-current 2>/dev/null)'; PS1='\[\e[97m\]\[\e[30;107m\]\[\e[39m\] \[\e[97;102m\]\[\e[39m\] \[\e[30;1m\]\u@\h\[\e[22;39m\] \[\e[92;106m\]\[\e[39m\] \[\e[30;1m\]\w\[\e[39m\] \[\e[96;105m\]\[\e[39m\] \[\e[30;1m\]${PS1_CMD1}\[\e[22;39m\] \[\e[95;101m\]\[\e[39m\] \[\e[30;1m\]$?\[\e[22;39m\] \[\e[0;91m\]\n\[\e[0;1m\]\\$\[\e[0m\] '
