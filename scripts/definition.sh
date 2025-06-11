#!/usr/bin/bash

# Prints definition of given word.
#
# Usage:
# `./definition.sh <word>`

function eprint() {
    >&2 echo -e "\x1b[91mError:\x1b[0m $1";
}

# Checks if word is empty or contains special characters
if [[ -z "$1" || "$1" =~ [\/] ]]; then
    eprint "Invalid input";
    exit 1;
fi

query=$(curl -s --connect-timeout 5 --max-time 10 \
    "https://api.dictionaryapi.dev/api/v2/entries/en/$1");

# Checks connection error
if [ $? -ne 0 ]; then
    eprint "Connection error";
    exit 1;
fi

# Checks invalid word response
if [[ "$query" == *"No Definitions Found"* ]]; then
    eprint "Invalid word";
    exit 1;
fi

echo "$query" | jq -r '
    .[0] as $entry |
    "\u001b[1m\u001b[97m\($entry.word)\u001b[0m \($entry.phonetic // "N/A")\n",
    "\u001b[4mDefinitions:\u001b[0m",
    ($entry.meanings[] |
        "  [\(.partOfSpeech)]" + (
            if (.synonyms | length) > 0 then
                " \u001b[30m~ " + (.synonyms | join(", ")) + "\u001b[0m"
            else
                empty
            end
        ),
        (.definitions | to_entries[] |
            "    \u001b[30m\u001b[1m\((.key + 1)).\u001b[0m " +
            "\u001b[37m\(.value.definition)\u001b[0m")
    )
';
