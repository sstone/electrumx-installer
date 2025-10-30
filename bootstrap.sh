#!/bin/bash
if [ -d ~/.electrumx-installer ]; then
    echo "~/.electrumx-installer already exists."
    echo "Either delete the directory or run ~/.electrumx-installer/install.sh directly."
    exit 1
fi
if which git > /dev/null 2>&1; then
    git clone -b recovery https://github.com/sstone/electrumx-installer ~/.electrumx-installer
    cd ~/.electrumx-installer/
else
    which wget > /dev/null 2>&1 && which unzip > /dev/null 2>&1 || { echo "Please install git or wget and unzip" && exit 1 ; }
    wget https://github.com/sstone/electrumx-installer/archive/recovery.zip -O /tmp/electrumx-recovery.zip
    unzip /tmp/electrumx-recovery.zip -d ~/.electrumx-installer
    rm /tmp/electrumx-recovery.zip
    cd ~/.electrumx-installer/electrumx-installer-recovery/ 
fi
if [[ $EUID -ne 0 ]]; then
    which sudo > /dev/null 2>&1 || { echo "You need to run this script as root" && exit 1 ; }
    sudo -H ./install.sh "$@"
else
    ./install.sh "$@"
fi
