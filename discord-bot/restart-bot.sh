#!/bin/bash

SCRIPT_NAME="BOP-BOT.py"

# Finde und beende das Python-Skript
pkill -f "$SCRIPT_NAME"


python3 /var/BOP-discord/BOP-BOT.py > /dev/null 2>&1
