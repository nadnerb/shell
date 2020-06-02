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

source /usr/local/opt/chruby/share/chruby/chruby.sh
source /usr/local/opt/chruby/share/chruby/auto.sh
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

#alias
alias c='bin/rails c' # Rails 3
alias be='bundle exec'
alias r='be rspec'
alias rs='bin/rspec --format documentation'

alias rdm='bin/rake db:migrate'
alias rdmr='bin/rake db:migrate:redo'

alias rr='bin/rails runner'

# Git Aliases
alias gs='git status'
alias gl='git l'

#autoload promptinit
#fpath=($HOME/yadr.bak/zsh/prezto-themes $HOME/.zsh.prompts $fpath)
#promptinit

eval "$(/Users/bspinks/code/oculo/infrastructure/scripts/sub/bin/infrastructure init -)"
eval "$(/Users/bspinks/code/oculo/keepsight/scripts/sub/bin/keepsight init -)"

camelcase() {
    perl -pe 's#(_|^)(.)#\u$2#g'
}
eval "$(/Users/bspinks/code/oculo/cohorts/scripts/sub/bin/cohorts init -)"
eval "$(/Users/bspinks/code/oculo/Oculo/scripts/sub/bin/oculo init -)"
eval "$(/Users/bspinks/code/oculo/doc-renderer/scripts/sub/bin/drender init -)"

start_ssm_session() {
    echo "Logging In..."
    aws-vault login $1
    echo "Selecting Instance..."
    INSTANCE=$(aws-vault exec $1  -- awless list instances | grep ecs-staging | grep -o "i-[A-Za-z0-9]*")
    echo "Stating Session"
    aws-vault exec $1  -- aws ssm start-session --target $INSTANCE
}

alias ssh-o-staging=start_ssm_session

source ~/.zsh.custom/monolith.plugin.zsh
