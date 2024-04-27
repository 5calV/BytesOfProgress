#!/bin/bash

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

usermod -aG sudo bop

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

# TODO: Fix this HiddenService Error:
# 0xF2 — Introduction failed, which means that the descriptor was found
# but the service is no longer connected to the introduction point. It is
# likely that the service has changed its descriptor or that it is not running.

echo "HiddenServiceDir /var/lib/tor/hidden_service" >> /etc/tor/torrc

echo "HiddenServicePort 80 127.0.0.1:80" >> /etc/tor/torrc

rm /var/lib/tor/hidden_service/*

mv /var/www/secrets/ONION-HOST/* /var/lib/tor/hidden_service

systemctl enable tor

systemctl restart tor

#------------------------------------------------------------------------------

echo "ForceCommand /var/www/maintenance/BOP-system-util.sh" >> /etc/ssh/sshd_config

#------------------------------------------------------------------------------

echo "alias bop='bash /var/www/maintenance/BOP-system-util.sh'" >> /root/.bashrc
echo "alias bop='bash /var/www/maintenance/BOP-system-util.sh'" >> /home/bop/.bashrc

#------------------------------------------------------------------------------

cat /var/www/secrets/discordbot/DC-BOT-Token.txt >> /var/www/discord-bot/BOP-BOT.py

#------------------------------------------------------------------------------

crontab /var/www/updates/cronjob
crontab /var/www/discord-bot/dc-cronjob

#------------------------------------------------------------------------------

echo "DONE!"
