#!/bin/sh

dotfiles_zsh=(zpreztorc zlogin zlogout zpreztorc zprezto zprofile zshenv zshrc)
dotfiles_bash=(inputrc bashrc profile)
dotfiles_mutt=(goobookrc muttrc mutt mailcap mailrc gnupg/gpg-agentconf gnupg/gpgconf)
dotfiles_muttofflineimap=(offlineimap offlineimaprc msmtprc)
dotfiles_mac=(slate)
dotfiles_other=(vimrc gitconfig gitignore)
dotfiles_cleanup=(${dotfiles_zsh[*]} ${dotfiles_bash[*]} ${dotfiles_mutt[*]} ${dotfiles_muttofflineimap[*]} ${dotfiles_mac[*]} ${dotfiles_other[*]})

echo "\nkciredor's dotfiles deploy\n\n** Have you cloned dotfiles recursively? If not: git submodule update --init --recursive before you deploy **\n"

read -p "Remove currently supported dotfiles from homefolder? [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    for item in ${dotfiles_cleanup[*]}; do
        rm -rf ~/.$item
    done

    echo "Removed: ${dotfiles_cleanup[*]}"
fi

echo "\n"
read -p "Use zsh? (otherwise installs bash dotfiles) [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "\ninstall zsh\n"

    for item in ${dotfiles_zsh[*]}; do
        ln -s `pwd`/$item ~/.$item
    done
else
    echo "\ninstall bash\n"

    for item in ${dotfiles_bash[*]}; do
        ln -s `pwd`/$item ~/.$item
    done
fi

echo "\n"
read -p "Install mail setup (includes mutt) [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "\ninstall mutt\n"

    mkdir -p ~/.gnupg/

    for item in ${dotfiles_mutt[*]}; do
        ln -s `pwd`/$item ~/.$item
    done

    echo "\n"
    read -p "Use mutt with offlineimap? [y/n] " -n 1 -r

    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "\ninstall mutt with offlineimap\n"

        mkdir ~/.maildir && chmod 700 ~/.maildir

        for item in ${dotfiles_muttofflineimap[*]}; do
            ln -s `pwd`/$item ~/.$item
        done
    fi
fi

echo "\n"
read -p "Install Mac OS specifics [y/n] " -n 1 -r

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "\ninstall mac dotfiles\n"

    for item in ${dotfiles_mac[*]}; do
        ln -s `pwd`/$item ~/.$item
    done
fi

echo "\nInstalling remaining dotfiles"

for item in ${dotfiles_other[*]}; do
    ln -s `pwd`/$item ~/.$item
done

mkdir -p ~/.vim/backup/
mkdir -p ~/.vim/bundle/
ln -s `pwd`/vundle ~/.vim/bundle/vundle

echo "\n\n**** Done (now install bundles from within vim using :BundleInstall)\n\n"
