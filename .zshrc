# ohmyzsh settings

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

unalias gcm

# env vars

export CDK_NEW_BOOTSTRAP=1
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1


# brew ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"

# nvm

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# homebrew

export HOMEBREW_NO_ANALYTICS=1

# oh my zshell

DISABLE_UPDATE_PROMPT=true

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
# alias cd='zoxide'
alias activate='. .venv/bin/activate'



# functions

new_django_project() {
    if [ -z "$1" ]
    then
        echo "Please enter your project name: "
        read project_name
    else
        project_name="$1"
    fi
    # make sure you have django-admin installed globally in a 3.10 interpreter
    curl https://raw.githubusercontent.com/knowsuchagency/django-template/main/install.sh | bash -s "$project_name"
}

alias new-django-project='new_django_project'

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

eval "$(zoxide init zsh)"

# carapace
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# golang
export PATH="$(go env GOPATH)/bin:$PATH"
