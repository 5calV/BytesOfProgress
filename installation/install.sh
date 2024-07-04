#!/bin/bash

echo '
  ____        _             ____   __ _____
 |  _ \      | |           / __ \ / _|  __ \
 | |_) |_   _| |_ ___  ___| |  | | |_| |__) | __ ___   __ _ _ __ ___  ___ ___
 |  _ <| | | | __/ _ \/ __| |  | |  _|  ___/  __/ _ \ / _  |  __/ _ \/ __/ __|
 | |_) | |_| | ||  __/\__ \ |__| | | | |   | | | (_) | (_| | | |  __/\__ \__ \
 |____/ \__, |\__\___||___/\____/|_| |_|   |_|  \___/ \__, |_|  \___||___/___/
         __/ |                                         __/ |
        |___/                                         |___/
'

sleep 1.5


apt update
apt full-upgrade -y
apt autoremove -y

apt install sudo -y
apt install nginx -y
apt install lm-sensors -y
apt install cron -y
apt install ufw -y
apt install unattended-upgrades -y
apt install htop -y
apt install iftop -y
apt install apt-transport-https -y
apt install gpg -y

apt install python3-pip -y
pip install --break-system-packages  discord.py

systemctl enable unattended-upgrades

usermod -aG sudo admin

chmod +x /var/www/maintenance/BOP-system-util.sh

#------------------------------------------------------------------------------

rm /etc/nginx/sites-available/default

cp /var/www/installation/default /etc/nginx/sites-available/default
cp /var/www/installation/default /etc/nginx/sites-enabled/default

systemctl restart nginx

mv  /var/www/installation/tor.list /etc/apt/sources.list.d/tor.list

wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null

apt update

apt install tor deb.torproject.org-keyring -y

echo "HiddenServiceDir /var/lib/tor/hidden_service" >> /etc/tor/torrc

echo "HiddenServicePort 80 127.0.0.1:80" >> /etc/tor/torrc

rm /var/lib/tor/hidden_service/*

cp /var/BOP-secrets/ONION-HOST/* /var/lib/tor/hidden_service

systemctl enable tor

systemctl restart tor

#------------------------------------------------------------------------------

echo "alias bop='bash /var/www/maintenance/BOP-system-util.sh'" >> /root/.bashrc
echo "alias bop='bash /var/www/maintenance/BOP-system-util.sh'" >> /home/bop/.bashrc

#------------------------------------------------------------------------------

mkdir /var/BOP-discord

mv /var/www/discord-bot/BOP-BOT.py /var/BOP-discord/BOP-BOT.py

cat /var/BOP-secrets/discordbot/DC-BOT-Token.txt >> /var/BOP-discord/BOP-BOT.py

#------------------------------------------------------------------------------

crontab /var/www/installation/cronjob

#------------------------------------------------------------------------------

echo "DONE!"

echo "It is recommended to perform a reboot!"
echo "After rebooting you will be able to use the BytesOfProgress System Utility by executing the command: bop"
