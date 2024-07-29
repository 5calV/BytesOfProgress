#!/bin/bash

SCRIPT_NAME="BOP-BOT.py"

pkill -f "$SCRIPT_NAME"

python3 /var/BOP-discord/BOP-BOT.py > /dev/null 2>&1

echo

echo 'BOP Discord bot restarted!'

sleep 3
