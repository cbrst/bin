#!/usr/bin/env bash

# NOTE: This script needs (start-server)

# Homebrew's /usr/local/bin/emacs is a shell script that calls Emacs with -nw
# We (I) don't want that...
if [[ $OSTYPE == "darwin13" ]]; then
	EMACS=/Applications/Emacs.app/Contents/MacOS/Emacs
else
	EMACS=emacs
fi

# Also, seems like Homebrew's Emacs doesn't assume the file I want is in $PWD
# It seems to think it's in $HOME (-_-)
FILE="$PWD/$1"

# Check if $FILE is a file, then open it in a running session, or start a new
# one if there isn't one running.
# If it's not a file, just focus Emacs, or launch a new empty session.
if [[ -f "$FILE" ]]; then
	emacsclient --no-wait "$FILE" &> /dev/null || $EMACS "$FILE" &
else
	emacsclient --eval "(raise-frame)" &> /dev/null || $EMACS &
fi
