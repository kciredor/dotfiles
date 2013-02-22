#!/bin/sh

echo "\n\n**** Removing current config files"

rm ~/.gitconfig
rm ~/.gitignore
rm ~/.inputrc
rm ~/.profile
rm ~/.vimrc
rm ~/.muttrc
rm ~/.offlineimaprc
rm ~/.mailcap
rm ~/.msmtprc
rm ~/.goobookrc

echo "\n**** Deploying sweetness"

ln -s `pwd`/gitconfig ~/.gitconfig
ln -s `pwd`/gitignore ~/.gitignore
ln -s `pwd`/inputrc ~/.inputrc
ln -s `pwd`/profile ~/.profile
ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/muttrc ~/.muttrc
ln -s `pwd`/offlineimaprc ~/.offlineimaprc
ln -s `pwd`/mailcap ~/.mailcap
ln -s `pwd`/msmtprc ~/.msmtprc
ln -s `pwd`/goobookrc ~/.goobookrc

mkdir -p ~/.vim/backup/
mkdir -p ~/.vim/bundle/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

mkdir -p ~/.mutt/cache/headers
mkdir ~/.mutt/cache/bodies
mkdir ~/.mutt/accounts
touch ~/.mutt/certificates
git clone https://github.com/altercation/mutt-colors-solarized ~/.mutt/mutt-colors-solarized
ln -s `pwd`/mailrun.sh ~/.mutt/mailrun.sh
cd ~/.mutt && wget http://filibusta.crema.unimi.it/~gufo/files/view_attachment.sh && chmod 700 view_attachment.sh

mkdir ~/.offlineimap && chmod 700 ~/.offlineimap
ln -s `pwd`/offlineimap-support.py ~/.offlineimap/offlineimap-support.py
mkdir ~/.maildir && chmod 700 ~/.maildir

echo "\n\n**** Done (now install bundles from within vim)\n\n"
