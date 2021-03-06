# $USER's Dotfiles

Because people keep cloning this repo

## Pre-Deployment

If you've just cloned this repo, there are a few important things you should do **before** deploying.
Edit your gitconfig to reflect your own credentials, including your name.
If you wish to use txtnotify, you will need to create a Twilio account and follow the configuration options in `txtnotify(1)`.
Please, unless you work at AT&T and have the ability to reduce my phone bill, **do not** deploy
my ssh_pubkeys. If you do, I will quietly weep, then ssh into your box and install a rootkit.
You have been warned.

## Installation

There's a really simple install script in `meta/install.sh` that links
the things in a list into your homedir. 

    $ git clone https://github.com/justjake/Dotfiles ~/.dotfiles

Print out the list of installable configurations:

    $ ~/.dotfiles/meta/install.sh

I usually install like this:

    $ zsh ~/.dotfiles/meta/install.sh dotfiles submodules ssh-config

## Configuration

Type `hostsettings` to edit your configuration file for this host.

Type `globalsettings` to edit the global zshrc

## Vim

Vim uses Vundle for plugin management.

Vim will complain loudly if you don't have Vundle.vim going. Make sure you `git
submodule init` or install with submodules before trying to use it, or download
and extract an archive of Vundle.vim to ~/.vim/bundle/Vundle.

Once you launch Vim for the first time, type `:BundleInstall` to get all the
nifty vim plugins.
