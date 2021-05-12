#!/bin/bash

dotfiles_zsh=(zshrc zsh_plugins.txt)
dotfiles_fish=(config/fish/config.fish config/fish/fishfile)
dotfiles_mutt=(muttrc mutt mailcap mailrc goobookrc urlview)
dotfiles_muttoffline=(mbsyncrc msmtprc notmuch-config)
dotfiles_x=(Xdefaults Xmodmap xinitrc xbindkeysrc config/awesome/battery.lua config/awesome/rc.lua)
dotfiles_mac=(yabairc skhdrc)
dotfiles_other=(vimrc config/nvim/init.vim gitconfig gitignore tmux.conf gnupg/gpg-agent.conf gnupg/gpg.conf gnupg/scdaemon.conf radare2rc gdbinit lldbinit)
dotfiles_cleanup=(profile inputrc bashrc bash_history ${dotfiles_zsh[*]} ${dotfiles_fish[*]} ${dotfiles_mutt[*]} ${dotfiles_muttoffline[*]} ${dotfiles_x[*]} ${dotfiles_mac[*]} ${dotfiles_other[*]})

echo -e "\nkciredor's dotfiles deploy\n\n"

read -p "Remove currently supported dotfiles from homefolder? [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    for item in ${dotfiles_cleanup[*]}; do
        rm -rf ~/.$item
    done

    echo -e "\n\n-- Removed: ${dotfiles_cleanup[*]}"
fi

read -p "Use zsh [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n-- Installing zsh\n"

    for item in ${dotfiles_zsh[*]}; do
        ln -s `pwd`/$item ~/.$item
    done
fi

echo
read -p "Use fish [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n-- Installing fish\n"

    for item in ${dotfiles_fish[*]}; do
        ln -s `pwd`/$item ~/.$item
    done
fi

read -p "Install mail setup (includes mutt) [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n-- Installing mutt\n"

    mkdir -p ~/.gnupg/

    for item in ${dotfiles_mutt[*]}; do
        ln -s `pwd`/$item ~/.$item
    done

    rm -rf ~/.mutt/config

    read -p "Use mutt offline? (macOS preferred because of specific config vs Linux) [y/n] " -n 1 -r

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "\n-- Installing offline setup for mutt\n"

        mkdir -p ~/.maildir && chmod 700 ~/.maildir

        for item in ${dotfiles_muttoffline[*]}; do
            ln -s `pwd`/$item ~/.$item
        done

        ln -s ~/.mutt/offline_config ~/.mutt/config
    else
        ln -s ~/.mutt/online_config ~/.mutt/config
    fi
fi

echo
read -p "Install X specifics [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n-- Install X dotfiles\n"

    mkdir -p `pwd`/.config/awesome/

    for item in ${dotfiles_x[*]}; do
        ln -s `pwd`/$item ~/.$item
    done
fi

echo
read -p "Install Mac OS specifics [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n-- Install Mac dotfiles\n"

    for item in ${dotfiles_mac[*]}; do
        ln -s `pwd`/$item ~/.$item
    done
fi

echo
echo -e "-- Installing remaining dotfiles"

mkdir -p ~/.config/nvim

for item in ${dotfiles_other[*]}; do
    ln -s `pwd`/$item ~/.$item
done

echo -e "\n\nDONE\n"
