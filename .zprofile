eval "$(/opt/homebrew/bin/brew shellenv)"

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


ln -s ~/.pyenv/bin/pyenv ~/.local/bin/pyenv 2>/dev/null

# Created by `pipx` on 2022-09-18 04:13:28
export PATH="$PATH:/Users/stephanfitzpatrick/.local/bin"


# Added by Toolbox App
export PATH="$PATH:/Users/stephanfitzpatrick/Library/Application Support/JetBrains/Toolbox/scripts"

# Added by OrbStack: command-line tools and integration
source ~/.orbstack/shell/init.zsh 2>/dev/null || :
