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
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

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
    pipx run copier copy gh:knowsuchagency/django-template -d project_name=$project_name $project_name
    cd $project_name
    just init runserver
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

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}


eval "$(github-copilot-cli alias -- "$0")"

eval "$(starship init zsh)"


eval "$(zoxide init zsh)"

# bun
export BUN_INSTALL="$HOME/Library/Application Support/reflex/bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"

# Added by Windsurf
export PATH="/Users/stephanfitzpatrick/.codeium/windsurf/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Bun
alias bunx='bun x'

# Claude
alias claude="/Users/stephanfitzpatrick/.claude/local/claude"
alias ccp="claude  --dangerously-skip-permissions"

# carapace
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# golang
export PATH="$(go env GOPATH)/bin:$PATH"

# helix
export EDITOR="hx"

# lazygit
alias lg="lazygit"

# jujutsu push parent function
jjp() {
    local target_branch="${1}"
    
    if [ -z "$target_branch" ]; then
        echo "Usage: jjp <branch-name>"
        echo "Sets the specified branch to @- and pushes it to remote"
        return 1
    fi

    # Check for AI attribution in both @- and @
    check_anthropic_coauthor || return $?
    
    echo "Setting $target_branch to @- and pushing..."
    jj bookmark set "$target_branch" -r @- --allow-backwards && jj git push --branch "$target_branch" --allow-new
}

# check @- commit and @ working set for anthropic co-author and exit with code 2 if found
check_anthropic_coauthor() {
    # Check the @- commit (parent)
    local commit_msg=$(jj log -r @- --no-graph -T description 2>/dev/null)
    
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to get commit message for @-" >&2
        exit 1
    fi
    
    # Check for noreply@anthropic.com (case-sensitive) in @-
    if echo "$commit_msg" | grep -q "noreply@anthropic.com"; then
        echo "ERROR: Parent commit (@-) contains AI attribution which may cause automatic rejection by project policies. Please edit the parent commit description and remove AI attribution." >&2
        exit 2
    fi
    
    # Check for Co-Authored-By: Claude (case-insensitive) in @-
    if echo "$commit_msg" | grep -qi "Co-Authored-By: Claude"; then
        echo "ERROR: Parent commit (@-) contains AI attribution which may cause automatic rejection by project policies. Please edit the parent commit description and remove AI attribution." >&2
        exit 2
    fi
    
    # Check the @ working set description
    local working_msg=$(jj log -r @ --no-graph -T description 2>/dev/null)
    
    if [ $? -ne 0 ]; then
        echo "ERROR: Failed to get working set description for @" >&2
        exit 1
    fi
    
    # Check for noreply@anthropic.com (case-sensitive) in @
    if echo "$working_msg" | grep -q "noreply@anthropic.com"; then
        echo "ERROR: Working set (@) contains AI attribution which may cause automatic rejection by project policies. Please edit the working set description with 'jj describe' and remove AI attribution." >&2
        exit 2
    fi
    
    # Check for Co-Authored-By: Claude (case-insensitive) in @
    if echo "$working_msg" | grep -qi "Co-Authored-By: Claude"; then
        echo "ERROR: Working set (@) contains AI attribution which may cause automatic rejection by project policies. Please edit the working set description with 'jj describe' and remove AI attribution." >&2
        exit 2
    fi
    
    echo "OK: Both @- commit and @ working set do not contain Anthropic attribution"
    return 0
}

eval "$(mise activate zsh)"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.tgenv/bin:$PATH"
