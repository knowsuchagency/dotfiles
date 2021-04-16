## Bootstrap

```zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/knowsuchagency/dotfiles/master/bootstrap.sh)"
```

---

## Update RC File

<details>

```zsh
# set paths

paths=(
    # homebrew/other
    '/usr/local/bin' 
    # mactex
    '/Library/TeX/texbin'
    # rust
    "$HOME/.cargo/bin"
    # nim
    "$HOME/.nimble/bin"
    #openjdk
    '/usr/local/opt/openjdk/bin'
    )

for p in ${(0a)paths}; do
  [[ ":$PATH:" != *":$p:"* ]] && export PATH="$p:${PATH}"
done

# set aliases

alias docker-kill-all='docker kill $(docker ps -q)'

alias tf='terraform'
alias py='python'
alias py3='python3'

alias gs='git status'
alias gc='git commit'
alias gcm='git commit -m'
alias gd='git diff'
alias ga='git add'
alias gp='git push'

alias dc='docker-compose'

# env vars

export CDK_NEW_BOOTSTRAP=1
export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1

# functions

function gpb {
  git push origin $(git branch | grep \* | cut -d ' ' -f2)
}

function gpbf {
  git push --no-verify origin $(git branch | grep \* | cut -d ' ' -f2)
}

function activate() {
    local cmd=":"
    local _iii
    declare -F deactivate >/dev/null && {
        echo "### Virtual env already active.  Use deactivate first." >&2
        return
    }
    [ "x$1" = "x-v" ] && cmd=echo
    for _iii in {.venv,venv,.env,env}/bin/activate
    do
        $cmd "### Checking for: $_iii" >&2
        if [ -f "$_iii" ]
        then
            echo "### Activating: $_iii" >&2
            . "$_iii"
            return
        fi
    done
    echo "Error: Unable to locate a virtual env." >&2
}

# starship prompt

eval "$(starship init zsh)"
```

</details>

---

## [Theme terminal](https://github.com/lysyi3m/macos-terminal-themes)
