# ohmyzsh settings

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

unalias gcm

# aliases

alias docker-kill-all='docker kill $(docker ps -q)'

alias tf='terraform'
alias tg='terragrunt'
alias py='python'
alias py3='python3'

alias pip-uninstall-all='pip freeze | grep -v "^-e" | xargs pip uninstall -y'

alias gs='git status'
alias gc='git commit'
alias gd='git diff'
alias ga='git add'
alias gp='git push'
alias gpr='git pull --rebase'

alias dc='docker-compose'

# functions

gpb () {
    local current_branch=$(git branch --show-current)
    git push --set-upstream origin "$current_branch"
}

activate_pyenv() {
    if [ -z "$1" ]
    then
        echo "Please provide the environment name"
        return 1
    fi

    ENV_PATH="$(pyenv root)/versions/$1"

    if [ ! -d "$ENV_PATH" ]
    then
        echo "Environment $1 does not exist"
        return 1
    fi

    echo "Activating $1"
    source "$ENV_PATH/bin/activate"
}

function gpbf {
  git push --no-verify origin $(git branch | grep \* | cut -d ' ' -f2)
}


function gcm {
  if [ -n "$CO_AUTHOR" ]; then
    git commit -m "$1"$'\n\n'"$CO_AUTHOR"
  else
    git commit -m "$1"
  fi
}

eval "$(github-copilot-cli alias -- "$0")"

eval "$(starship init zsh)"

eval "$(direnv hook zsh)"
