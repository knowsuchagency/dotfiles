#!/bin/bash

set -x

xcode-select --install

echo install homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

PATH="/usr/local/bin:$PATH"

brew install python

brew install pipx

pipx install pdm

pipx install "python-dotenv[cli]"

pipx ensurepath

curl https://pyenv.run | bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

nvm install node # "node" is an alias for the latest version

brew install gh

brew install just

brew install pandoc

brew install doctl

brew install awscli

brew install firebase-cli

brew install tldr

brew install tree

brew install buildkit

brew install hugo

brew install starship

brew install nim

brew install helm

brew install jc

brew install jello

brew install postgresql

brew install gibo

brew install flyctl

brew install direnv

brew install atuin

brew install ruff

brew install uv

brew install fzf

brew install zoxide

brew install supabase/tap/supabase

brew tap aws/tap

brew tap homebrew/cask-fonts

brew install font-jetbrains-mono --cask

brew install font-jetbrains-mono-nerd-font --cask

brew install google-chrome --cask

brew install jetbrains-toolbox --cask

brew install dash --cask

brew install visual-studio-code --cask

brew install docker --cask

brew install bartender --cask

brew install --cask http-toolkit

brew install istat-menus --cask

brew install little-snitch --cask

brew install rust --cask

brew install spotify --cask

brew install private-internet-access --cask

brew install --cask aws-vault

brew install --cask google-cloud-sdk

npm install -g @aws-amplify/cli

npm install -g aws-cdk

npm install -g vercel

npm install -g concurrently

npm install -g @githubnext/github-copilot-cli

echo "configure google cloud sdk"

source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

echo configure git

git config --global user.name "Stephan Fitzpatrick"

git config --global user.email knowsuchagency@gmail.com

git config --global pull.ff only

echo install ohmyzsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# overwrite zshrc and zlogin
mv ~/.zlogin ~/.zlogin.bak
mv ~/.zshrc ~/.zshrc.bak
curl -L https://raw.githubusercontent.com/knowsuchagency/dotfiles/master/.zprofile > ~/.zprofile
curl -L https://raw.githubusercontent.com/knowsuchagency/dotfiles/master/.zshrc > ~/.zshrc
