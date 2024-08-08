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

apt install shellinabox -y
apt install fcgiwrap -y
apt install apache2-utils -y

systemctl enable unattended-upgrades

usermod -aG sudo bop-admin

chmod +x /var/www/maintenance/BOP-system-util.sh

rm -rf /var/www/html

mkdir /var/www/html

#------------------------------------------------------------------------------

ufw allow 22
ufw allow 80
ufw allow 8080
ufw allow 8088
ufw allow 4200

#------------------------------------------------------------------------------

rm /etc/nginx/sites-available/default

cp /var/www/installation/default /etc/nginx/sites-available/default
cp /var/www/installation/default /etc/nginx/sites-enabled/default

systemctl restart nginx

#------------------------------------------------------------------------------

echo "alias bop='bash /var/www/maintenance/BOP-system-util.sh'" >> /root/.bashrc
echo "alias bop='bash /var/www/maintenance/BOP-system-util.sh'" >> /home/bop-admin/.bashrc

#------------------------------------------------------------------------------

crontab /var/www/installation/cronjob

#------------------------------------------------------------------------------

rm /etc/motd

mv /var/www/installation/motd /etc/motd

#------------------------------------------------------------------------------

# Management panel

systemctl start fcgiwrap
systemctl enable fcgiwrap

mkdir /usr/lib/cgi-bin

cp /var/www/installation/management-panel/monitoring.sh /usr/lib/cgi-bin/monitoring.sh

chmod +x /usr/lib/cgi-bin/monitoring.sh

mkdir /var/www/management

cp /var/www/installation/management-panel/* /var/www/management/

chmod +x /usr/lib/cgi-bin/monitoring.sh

read -p "Enter username for web admin panel: " username

sudo htpasswd -c /etc/nginx/.htpasswd $username

systemctl restart nginx

#------------------------------------------------------------------------------

# Onion mirror

mv /var/www/installation/tor.list /etc/apt/sources.list.d/tor.list

wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null

apt update

apt install tor deb.torproject.org-keyring -y

systemctl restart tor

apt install nyx -y

echo "HiddenServiceDir /var/lib/tor/hidden_service" >> /etc/tor/torrc

echo "HiddenServicePort 80 127.0.0.1:80" >> /etc/tor/torrc

rm -rf /var/lib/tor/hidden_service/*

cp /var/BOP-secrets/ONION-HOST/* /var/lib/tor/hidden_service

systemctl enable tor

systemctl restart tor

#------------------------------------------------------------------------------

echo "DONE!"

echo "It is recommended to perform a reboot!"
echo "After rebooting you will be able to use the BytesOfProgress System Utility by executing the command: bop, or use the admin panel on 8088."

