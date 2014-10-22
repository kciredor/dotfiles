#!/bin/bash

dotfiles_zsh=(zpreztorc zlogin zlogout zprofile zshenv zshrc)
dotfiles_bash=(inputrc bashrc)
dotfiles_mutt=(goobookrc muttrc mutt mailcap mailrc gnupg/gpg-agent.conf gnupg/gpg.conf)
dotfiles_muttofflineimap=(offlineimap offlineimaprc msmtprc)
dotfiles_x=(Xmodmap Xdefaults Xresources xinitrc config/awesome/battery.lua config/awesome/rc.lua)
dotfiles_mac=(slate, slatelaunchers)
dotfiles_other=(vimrc gitconfig gitignore)
dotfiles_cleanup=(profile zprezto ${dotfiles_zsh[*]} ${dotfiles_bash[*]} ${dotfiles_mutt[*]} ${dotfiles_muttofflineimap[*]} ${dotfiles_x[*]} ${dotfiles_mac[*]} ${dotfiles_other[*]})

echo -e "\nkciredor's dotfiles deploy\n\n** Have you cloned dotfiles recursively? If not: git submodule update --init --recursive before you deploy **\n"

read -p "Remove currently supported dotfiles from homefolder? [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    for item in ${dotfiles_cleanup[*]}; do
        rm -rf ~/.$item
    done

    echo -e "\n\n-- Removed: ${dotfiles_cleanup[*]}"
fi

echo -e "\n"
read -p "Use zsh? (otherwise installs bash dotfiles) [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n-- Installing zsh\n"

    ln -s `pwd`/zprezto ~/.zprezto

    for item in ${dotfiles_zsh[*]}; do
        ln -s ~/.zprezto/runcoms/$item ~/.$item
    done
else
    echo -e "\n-- Installing bash\n"

    for item in ${dotfiles_bash[*]}; do
        ln -s `pwd`/$item ~/.$item
    done

    ln -s ~/.bashrc ~/.profile
fi

echo -e "\n"
read -p "Install mail setup (includes mutt) [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n-- Installing mutt\n"

    mkdir -p ~/.gnupg/

    for item in ${dotfiles_mutt[*]}; do
        ln -s `pwd`/$item ~/.$item
    done

    rm -rf ~/.mutt/specific_config

    echo -e "\n"
    read -p "Use mutt with offlineimap? [y/n] " -n 1 -r

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "\n-- Installing offlineimap setup for mutt\n"

        mkdir ~/.maildir && chmod 700 ~/.maildir

        for item in ${dotfiles_muttofflineimap[*]}; do
            ln -s `pwd`/$item ~/.$item
        done

        ln -s ~/.mutt/offlineimap_config ~/.mutt/specific_config
    else
        ln -s ~/.mutt/imap_config ~/.mutt/specific_config
    fi
fi

echo -e "\n"
read -p "Install X specifics [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n-- Install X dotfiles\n"

    mkdir -p `pwd`/.config/awesome/

    for item in ${dotfiles_x[*]}; do
        ln -s `pwd`/$item ~/.$item
    done
fi

echo -e "\n"
read -p "Install Mac OS specifics [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n-- Install Mac dotfiles\n"

    for item in ${dotfiles_mac[*]}; do
        ln -s `pwd`/$item ~/.$item
    done
fi

echo -e "\n\n-- Installing remaining dotfiles"

for item in ${dotfiles_other[*]}; do
    ln -s `pwd`/$item ~/.$item
done

mkdir -p ~/.vim/backup/
mkdir -p ~/.vim/bundle/
ln -s `pwd`/vundle ~/.vim/bundle/vundle

echo -e "\n\n**** Done (now install bundles from within vim using :BundleInstall)\n\n"
