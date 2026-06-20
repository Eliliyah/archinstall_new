#!/usr/bin/env bash

#FUNCTIONS GO HERE

confirm() {         
    while true; do
        read -p "${1}" yn
        case $yn in
            [Yy]* ) $2; break;;
            [Nn]* ) echo "aborted"; exit;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}
example-function() {
    echo "Excellent. You haven't broken it. Yet."
}

confirm "Do you want to install the Blackarch keyring?"
confirm "Really? Do you think you're ever going to need that?"

#Install blackarch
cd/tmp
curl -O https://blackarch.org/strap.sh
chmod +x strap.sh
./strap.sh

confirm "Did it work?"


