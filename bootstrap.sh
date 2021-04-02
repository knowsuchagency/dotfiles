#!/bin/bash

set -x

xcode-select --install

echo install homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

PATH="/usr/local/bin:$PATH"

brew install python

brew install pipx

pipx install pdm

pipx ensurepath

curl https://pyenv.run | bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

nvm install node # "node" is an alias for the latest version

brew tap fishtown-analytics/dbt

brew install dbt

brew install stern

brew install doctl

brew install awscli

brew install tldr

brew install tree

brew install buildkit

brew install hugo

brew install terraform

brew install starship

brew tap lucagrulla/tap

brew install cw

brew install nim

brew install helm

brew tap aws/tap
brew install aws-sam-cli

brew tap homebrew/cask-fonts

brew install font-hack-nerd-font --cask

brew install visual-studio-code --cask

brew install jetbrains-toolbox --cask

brew install docker --cask

brew install dash --cask

brew install bartender --cask

brew install postman --cask

brew install istat-menus --cask

brew install little-snitch --cask

brew install franz --cask

brew install rust --cask

brew install spotify --cask

brew install private-internet-access --cask

brew install google-chrome --cask

brew install dotnet-sdk --cask

dotnet tool install fake-cli -g

dotnet new -i "fake-template::*"

npm install -g @aws-amplify/cli

npm install -g aws-cdk

echo configure git

git config --global user.name "Stephan Fitzpatrick"

git config --global user.email knowsuchagency@gmail.com

git config --global pull.ff only

echo install ohmyzsh

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
