#!/usr/bin/env zsh

DOTFILE_MODULES="$DOTFILES/modules"

# ZSH Functions
function fractal {
   local lines columns colour a b p q i pnew
   ((columns=COLUMNS-1, lines=LINES-1, colour=0))
   for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
       for ((a=-2.0; a<=1; a+=3.0/columns)) do
           for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
               ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
           done
           ((colour=(i/4)%8))
            echo -n "\\e[4${colour}m "
        done
        echo
    done
    echo -n "\e[49m"
}

#### setup stuff

# add all the bundles in a DIR to $PATH and $MANPATh
# a bundle is a directory that contains bin and man, and maybe lib
function bundle-dir {
    local BUNDLES
    BUNDLES="$1"
    if [[ -d "$BUNDLES" ]]; then
        for bundle in "$BUNDLES"/*; do
            if [[ -d "$bundle"/bin ]]; then
                PATH="$bundle/bin:$PATH"
            else
                PATH="$bundle:$PATH"
            fi
        done
    else
        echo "$BUNDLES does not exist"
    fi
}

#### Utilities

function this-script-dir {
    echo "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
}

function expand-string {
    eval echo "$1"
}

#### dotfile modules 
# folders that go someplace other than ~/ that have settings

function dotfile-module-install {
    local BUNDLE_DIR
    BUNDLE_DIR="$DOTFILE_MODULES/$1"
    echo installing $BUNDLE_DIR
    TARGET_LOC="$(expand-string "$(cat "$BUNDLE_DIR/.target")")"
    cd $HOME
    ln -s -v "$BUNDLE_DIR" "$TARGET_LOC"
}

function dotfile-module-list {
    ls "$DOTFILE_MODULES"
}

function dotfile-module-show {
    if [[ ! -d "$DOTFILE_MODULES/$1" ]] ; then
        echo "Module $1 does not exist"
    else
        echo \
"Dotfile Module:
    $DOTFILE_MODULES/$1

Link Location:
    $(cat "$DOTFILE_MODULES/$1/.target")
    $(expand-string "$(cat "$DOTFILE_MODULES/$1/.target")")

Contents:"
        ls -al "$DOTFILE_MODULES/$1"
    fi
}
    

