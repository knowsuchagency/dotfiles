#!/bin/bash

set -o verbose
set -o xtrace

echo install homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

PATH="/usr/local/bin:$PATH"

brew install python

brew install python@3.8

ln -s /usr/local/opt/python@3.8/bin/python3.8 /usr/local/bin/python3.8

python3 -m pip install -U pip

python3.8 -m pip install -U pip

echo install python cli utilities

python3.8 -m pip install pipx

python3.8 -m pipx ensurepath

PATH="$HOME/.local/bin:$PATH"

python3.8 -m pipx install "xonsh[ptk,pygments,mac]"
python3.8 -m pipx install black
python3.8 -m pipx install poetry
python3.8 -m pipx install httpie
python3.8 -m pipx install asciinema
python3.8 -m pipx install cookiecutter

brew install npm

brew install awscli

brew install tldr

brew install tree

brew install buildkit

brew install hugo

brew install docker-slim

brew install terraform

brew tap homebrew/cask-fonts

brew cask install font-hack-nerd-font

brew cask install visual-studio-code

brew cask install jetbrains-toolbox

brew cask install iterm2

brew cask install docker

brew cask install dash

brew cask install bartender

brew cask install postman

brew cask install istat-menus

brew cask install little-snitch

brew cask install franz

brew cask install rust

brew cask install spotify

brew cask install private-internet-access

brew cask install google-chrome

npm install -g @aws-amplify/cli

echo install nim

curl https://nim-lang.org/choosenim/init.sh -sSf | sh

echo configure git

git config --global user.name "Stephan Fitzpatrick"

git config --global user.email knowsuchagency@gmail.com

./reset_xonsh.py

chsh -s $(which xonsh)