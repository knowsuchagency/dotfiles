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
