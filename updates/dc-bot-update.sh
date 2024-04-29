#!/bin/bash

SCRIPT_NAME="BOP-BOT.py"

# Finde und beende das Python-Skript
pkill -f "$SCRIPT_NAME"

#------------------------------------------------------------------------------

rm -rf /var/BOP-discord/*

cp /var/www/discord-bot/BOP-BOT.py /var/BOP-discord/BOP-BOT.py

cat /var/BOP-secrets/discordbot/DC-BOT-Token.txt >> /var/BOP-discord/BOP-BOT.py

echo 'Please restart the bot with BOP System Utility.'