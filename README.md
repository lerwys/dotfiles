Personal dotfiles
=================

# Overview

Personal dotfiles.

# Installation Intructions

## Install via Makefile

1. make

## Install manually

Simply copy your .vimrc to your home:

1. cp .vimrc ~/.vimrc

Install deoplete dependencies:

2. pip3 install -r requeriments.txt --user

Create directories:

3. mkdir -p ~/.vim/backup
4. mkdir -p ~/.vim/swap
5. mkdir -p ~/.vim/undo

Install all included plugins:

6. vim +PluginInstall +qall
