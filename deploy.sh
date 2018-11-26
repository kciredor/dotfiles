#!/bin/bash

dotfiles_zsh=(zshrc antigen.zsh)
dotfiles_mutt=(goobookrc muttrc mutt mailcap mailrc urlview gnupg/gpg-agent.conf gnupg/gpg.conf)
dotfiles_muttofflineimap=(offlineimap offlineimaprc msmtprc notmuch-config)
dotfiles_x=(Xdefaults Xmodmap xinitrc xbindkeysrc config/awesome/battery.lua config/awesome/rc.lua)
dotfiles_mac=(chunkwmrc skhdrc)
dotfiles_other=(vimrc config/nvim/init.vim gitconfig gitignore tmux.conf radare2rc gdbinit)
dotfiles_cleanup=(profile inputrc bashrc bash_history ${dotfiles_zsh[*]} ${dotfiles_mutt[*]} ${dotfiles_muttofflineimap[*]} ${dotfiles_x[*]} ${dotfiles_mac[*]} ${dotfiles_other[*]})

echo -e "\nkciredor's dotfiles deploy\n\n"

read -p "Remove currently supported dotfiles from homefolder? [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    for item in ${dotfiles_cleanup[*]}; do
        rm -rf ~/.$item
    done

    echo -e "\n\n-- Removed: ${dotfiles_cleanup[*]}"
fi

echo -e "\n-- Installing zsh\n"

for item in ${dotfiles_zsh[*]}; do
    ln -s `pwd`/$item ~/.$item
done

read -p "Install mail setup (includes mutt) [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n-- Installing mutt\n"

    mkdir -p ~/.gnupg/

    for item in ${dotfiles_mutt[*]}; do
        ln -s `pwd`/$item ~/.$item
    done

    rm -rf ~/.mutt/specific_config

    read -p "Use mutt with offlineimap? (Linux preferred, not macOS) [y/n] " -n 1 -r

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "\n-- Installing offlineimap setup for mutt\n"

        mkdir -p ~/.maildir && chmod 700 ~/.maildir

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

echo -e "-- Installing remaining dotfiles"

mkdir -p ~/.config/nvim

for item in ${dotfiles_other[*]}; do
    ln -s `pwd`/$item ~/.$item
done

echo -e "\n\nDONE\n"
