#!/bin/bash

rm -rf /var/BOP-discord/*

mv /var/www/discord-bot/BOP-BOT.py /var/BOP-discord/BOP-BOT.py

cat /var/BOP-secrets/discordbot/DC-BOT-Token.txt >> /var/BOP-discord/BOP-BOT.py

python3 /var/BOP-discord/BOP-BOT.py > /dev/null 2>&1