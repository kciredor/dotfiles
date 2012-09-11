#!/bin/sh

echo "\n\n**** Removing current config files"

rm ~/.gitconfig
rm ~/.gitignore
rm ~/.inputrc
rm ~/.profile
rm ~/.vimrc

echo "\n**** Deploying sweetness"

ln -s `pwd`/gitconfig ~/.gitconfig
ln -s `pwd`/gitignore ~/.gitignore
ln -s `pwd`/inputrc ~/.inputrc
ln -s `pwd`/profile ~/.profile
ln -s `pwd`/vimrc ~/.vimrc

mkdir -p ~/.vim/backup/
mkdir -p ~/.vim/bundle/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo "\n\n**** Done (now install bundles from within vim)\n\n"
