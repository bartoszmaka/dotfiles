#! /bin/bash
difference() {
    if ! cmp $1 $2 >/dev/null 2>&1 ; then
        diff $1 $2
        echo "================================="
        echo
    else
        echo "$2 is synchronised"
    fi
}
difference ~/.vimrc .vimrc
difference ~/.zshrc .zshrc
difference ~/.rubocop.yml .rubocop.yml
difference ~/.config/redshift.conf redshift.conf
