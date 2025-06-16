# scripts

This folder contains scripts I made.

## Running scripts

Usage of each script is written in the comments in the script itself. Some
scripts I assign to a hotkey *(such as `audio_switch.sh`)*, so that I can run
them easily. It's also helpful to add the scripts to path or create alias, so
you don't have to write the full path of the script.

## Installation

You can use the `install.sh` script to copy the scripts without `.sh` extension
to given folder *(if no folder is given, it uses `/usr/local/bin` by default).*

```bash
chmod +x ./install.sh
./install.sh
# Or: ./install.sh /your/bin/folder
```

## List
- `audio_switch.sh`: switches between audio devices.
- `clipboard.sh`: displays clipboard history.
- `definition.sh`: prints definitions of given word.
- `extract.sh`: extracts given archive *(supports multiple archive types)*.
- `power_menu.sh`: displays power menu *(suspend, shutdown, restart)*.
