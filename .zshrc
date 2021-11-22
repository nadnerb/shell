zmodload zsh/zprof

# hack for early m1 homebrew issue
export EDITOR==/opt/Cellar/vim/8.2.3450/bin/vim
export VISUAL=/opt/Cellar/vim/8.2.3450/bin/vim

setopt HIST_IGNORE_SPACE

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="cloud"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git ruby autojump)
plugins=(git ruby)

source $ZSH/oh-my-zsh.sh

set -o vi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Autojump
[ -f /opt/etc/profile.d/autojump.sh ] && . /opt/etc/profile.d/autojump.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias be="bundle exec"
alias gp="./scripts/test && git push"
alias gpt="./scripts/testfrontend && git push"
alias rs="./bin/rspec --format documentation"
alias yt="yarn test --single-run --reporters mocha"

# override osx vim
# hack for early m1 homebrew issue
alias vi=/opt/Cellar/vim/8.2.3450/bin/vim
alias vim=/opt/Cellar/vim/8.2.3450/bin/vim

export FZF_DEFAULT_COMMAND='ag -p ~/.gitignore -g ""'

# ruby
source /opt/opt/chruby/share/chruby/auto.sh
source /opt/opt/chruby/share/chruby/chruby.sh

#go
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# general
export PATH=$PATH:$HOME/bin:/opt/bin:/usr/local/bin

bindkey -v
bindkey '^R' history-incremental-search-backward

export NODE_OPTIONS="--max-old-space-size=6144"

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/opt/nvm/nvm.sh" ] && . "/opt/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm completion

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

#export FREEDESKTOP_MIME_TYPES_PATH=/opt/Cellar/shared-mime-info/2.1/share/shared-mime-info/packages/freedesktop.org.xml

list-instances() {
  aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,InstanceId:InstanceId}" --filters Name=instance-state-name,Values=running --output table
}

list-instances-csl() {
  aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,InstanceId:InstanceId}" --filters Name=instance-state-name,Values=running --output table --profile csl
}

list-instances-dev() {
  aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,InstanceId:InstanceId}" --filters Name=instance-state-name,Values=running --output table --profile development
}

list-instances-services() {
  aws ec2 describe-instances --query "Reservations[*].Instances[*].{PublicIP:PublicIpAddress,Name:Tags[?Key=='Name']|[0].Value,Status:State.Name,InstanceId:InstanceId}" --filters Name=instance-state-name,Values=running --output table --profile services
}

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/Caskroom/miniforge/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/Caskroom/miniforge/base/etc/profile.d/conda.sh" ]; then
        . "/opt/Caskroom/miniforge/base/etc/profile.d/conda.sh"
    else
        export PATH="/opt/Caskroom/miniforge/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# this slows new terms down
# eval "$(mcfly init zsh)"

timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do /usr/bin/time $shell -i -c exit; done
}

chruby ruby-2.7.2
