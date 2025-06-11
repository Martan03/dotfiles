#!/usr/bin/bash

# Copies the scripts to `bin` folder. By default, it copies to
# `/usr/local/bin`, but you can change that by running the script with
# an argument:
# `./install.sh /your/path/to/bin`

BIN_DIR=${1:-/usr/local/bin};
mkdir -p "$BIN_DIR";

for f in *.sh; do
    base="$(basename "$f" .sh)";
    if [ "$base" = "install" ]; then
        continue;
    fi

    sudo cp "$f" "$BIN_DIR/$base";
    sudo chmod +x "$BIN_DIR/$base";
done
