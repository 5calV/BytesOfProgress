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

systemctl enable unattended-upgrades

usermod -aG sudo bop

chmod +x /var/www/maintenance/BOP-system-util.sh

#------------------------------------------------------------------------------

rm /etc/nginx/sites-available/default

mv /var/www/installation/default /etc/nginx/sites-available/default

systemctl restart nginx

mv  /var/www/installation/tor.list /etc/apt/sources.list.d/tor.list

wget -qO- https://deb.torproject.org/torproject.org/A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89.asc | gpg --dearmor | tee /usr/share/keyrings/tor-archive-keyring.gpg >/dev/null

apt update

apt install tor deb.torproject.org-keyring -y

echo "HiddenserviceDir /var/lib/tor/hidden_service" >> /etc/tor/torrc

echo "HiddenServicePort 80 127.0.0.1:80" >> /etc/tor/torrc

systemctl restart tor

#------------------------------------------------------------------------------

echo "ForceCommand /var/www/maintenance/BOP-system-util.sh" >> /etc/ssh/sshd_config

#------------------------------------------------------------------------------

echo "alias bop='bash /var/www/maintenance/BOP-system-util.sh'" >> /root/.bashrc
echo "alias bop='bash /var/www/maintenance/BOP-system-util.sh'" >> /home/bop/.bashrc

#------------------------------------------------------------------------------

crontab /var/www/updates/cronjob

#------------------------------------------------------------------------------

echo "DONE! Performing a reboot!"

reboot
