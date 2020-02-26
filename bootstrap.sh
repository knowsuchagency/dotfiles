#!/bin/bash

set -o verbose
set -o xtrace

echo install homebrew

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

PATH="/usr/local/bin:$PATH"

brew install python

python3 -m pip install -U pip

echo install python cli utilities

python3 -m pip install pipx

pipx ensurepath

python3 -m pipx install "xonsh[ptk,pygments,mac]"
python3 -m pipx install black
python3 -m pipx install poetry
python3 -m pipx install httpie

brew install npm

brew install awscli

brew install buildkit

brew tap homebrew/cask-fonts

brew cask install font-hack-nerd-font

brew cask install visual-studio-code

brew cask install jetbrains-toolbox

brew cask install iterm2

brew cask install docker

brew cask install bartender

brew cask install istat-menus

brew cask install little-snitch

brew cask install franz

brew cask install rust

brew cask install spotify

brew cask install private-internet-access

echo install nim

curl https://nim-lang.org/choosenim/init.sh -sSf | sh

echo configure git

git config --global user.name "Stephan Fitzpatrick"

git config --global user.email knowsuchagency@gmail.com

./reset_xonsh.py

chsh -s $(which xonsh)