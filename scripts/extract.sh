#!/usr/bin/bash

# Extracts given archive based on its extension.
#
# Usage:
# `./extract.sh <archive_path>`

if [ -z "$1" ]; then
    >&2 echo -e "\x1b[91mError:\x1b[0m No archive provided";
    exit 1;
fi

if [ ! -f "$1" ]; then
    >&2 echo -e "\x1b[91mError:\x1b[0m Provided archive not found";
fi

case $1 in
    *.zip) unzip "$1";;
    *.tar) tar -xvf "$1";;
    *.tar.xz) tar -xvf "$1";;
    *.tar.bz2) tar -jxvf "$1";;
    *.tar.gz) tar -zxvf "$1";;
    *.gz) gunzip "$1";;
    *.rar) 7z x "$1";;
    *.7z) 7z x "$1";;
    *)
        >&2 echo -e "\x1b[91mError:\x1b[0m Archive type not supported";
        exit 1;
        ;;
esac
