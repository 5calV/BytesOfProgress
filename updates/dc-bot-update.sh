#!/bin/bash

SCRIPT_NAME="BOP-BOT.py"

# Find and quit bot
pkill -f "$SCRIPT_NAME"

#------------------------------------------------------------------------------

rm -rf /var/BOP-discord/*

cp /var/www/discord-bot/BOP-BOT.py /var/BOP-discord/BOP-BOT.py

cat /var/BOP-secrets/discordbot/DC-BOT-Token.txt >> /var/BOP-discord/BOP-BOT.py

echo

echo 'Please restart the bot with BOP System Utility or perform a reboot.'

sleep 3