set -o vi
export EDITOR=vim
export VISUAL=vim

source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"


function powerline_precmd() {
  PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi


#prompt powerline

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Aliases

# Git Aliases
alias gs='git status'
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

#autoload promptinit
#fpath=($HOME/yadr.bak/zsh/prezto-themes $HOME/.zsh.prompts $fpath)
#promptinit

bindkey -v
bindkey '^R' history-incremental-search-backward

camelcase() {
    perl -pe 's#(_|^)(.)#\u$2#g'
}

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
