#!/bin/bash

set -x

xcode-select --install

echo install homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

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

brew install stern

brew install just

brew install doctl

brew install awscli

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

brew tap aws/tap

brew tap homebrew/cask-fonts

brew install font-jetbrains-mono --cask

brew install font-jetbrains-mono-nerd-font --cask

brew install google-chrome --cask

brew install jetbrains-toolbox --cask

brew install dash --cask

brew install visual-studio-code --cask

brew install slack --cask

brew install docker --cask

brew install bartender --cask

brew install --cask http-toolkit

brew install istat-menus --cask

brew install little-snitch --cask

brew install franz --cask

brew install rust --cask

brew install spotify --cask

brew install private-internet-access --cask

npm install -g @aws-amplify/cli

npm install -g aws-cdk

echo configure git

git config --global user.name "Stephan Fitzpatrick"

git config --global user.email knowsuchagency@gmail.com

git config --global pull.ff only

echo install ohmyzsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
