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

#export NVM_DIR="$HOME/.nvm"
#. "/usr/local/opt/nvm/nvm.sh"

# Aliases

# Git Aliases
alias gs='git status'
alias gl='git l'

#autoload promptinit
#fpath=($HOME/yadr.bak/zsh/prezto-themes $HOME/.zsh.prompts $fpath)
#promptinit

camelcase() {
    perl -pe 's#(_|^)(.)#\u$2#g'
}

source ~/.zsh.custom/monolith.plugin.zsh
