#!/bin/sh

# TODO: clean, deploy, deploy-bash, deploy-zsh, deploy-mutt-imap, deploy-mutt-offlineimap

echo "\n\n**** Removing current config files"

rm ~/.gitconfig
rm ~/.gitignore
rm ~/.inputrc
rm ~/.bashrc
rm ~/.vimrc
rm ~/.goobookrc
rm ~/.muttrc
rm ~/.mutt
# rm ~/.offlineimaprc
# rm ~/.mailcap
# rm ~/.mailrc
# rm ~/.msmtprc

echo "\n**** Deploying sweetness"

ln -s `pwd`/gitconfig ~/.gitconfig
ln -s `pwd`/gitignore ~/.gitignore
ln -s `pwd`/inputrc ~/.inputrc
ln -s `pwd`/bashrc ~/.bashrc
ln -s `pwd`/vimrc ~/.vimrc
ln -s `pwd`/muttrc ~/.muttrc
ln -s `pwd`/goobookrc ~/.goobookrc
ln -s `pwd`/mutt ~/.mutt
ln -s `pwd`/mutt/imap_config `pwd`/mutt/specific_config
# ln -s `pwd`/offlineimaprc ~/.offlineimaprc
# ln -s `pwd`/mailcap ~/.mailcap
# ln -s `pwd`/mailrc ~/.mailrc
# ln -s `pwd`/msmtprc ~/.msmtprc

# mkdir ~/.maildir && chmod 700 ~/.maildir

mkdir -p ~/.vim/backup/
mkdir -p ~/.vim/bundle/
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

echo "\n\n**** Done (now install bundles from within vim)\n\n"
