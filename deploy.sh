#!/bin/sh

echo "\n\n**** Removing current config files"

rm ~/.gitconfig
rm ~/.gitignore
rm ~/.inputrc
rm ~/.bashrc
rm ~/.vimrc
rm ~/.muttrc
rm ~/.mutt
rm ~/.mailcap
rm ~/.goobookrc

echo "\n**** Deploying sweetness"

ln -s `pwd`/gitconfig ~/.gitconfig
ln -s `pwd`/gitignore ~/.gitignore
ln -s `pwd`/inputrc ~/.inputrc
ln -s `pwd`/bashrc ~/.bashrc
ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/muttrc ~/.muttrc
ln -s `pwd`/mutt ~/.mutt
ln -s `pwd`/mutt/linux_specific_config `pwd`/mutt/specific_config
ln -s `pwd`/mailcap ~/.mailcap
ln -s `pwd`/goobookrc ~/.goobookrc

mkdir -p ~/.vim/backup/
mkdir -p ~/.vim/bundle/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo "\n\n**** Done (now install bundles from within vim)\n\n"
