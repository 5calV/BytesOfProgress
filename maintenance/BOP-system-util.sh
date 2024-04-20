#!/bin/bash

clear

echo 'Welcome to BytesOfProgress System Utility!'

echo

sleep 1

#------------------------------------------------------------------------------

echo 'CPU Temperature:'

sensors | grep Core

echo

#------------------------------------------------------------------------------

echo 'CPU Usage:'

grep -E '^cpu[0-9]+ ' /proc/stat | awk 'NR <= 2 {usage=($2+$4)*100/($2+$4+$5+$6)} {print "Core " NR-1 ": " usage "%"}'

echo

#------------------------------------------------------------------------------

echo 'RAM Usage:'

awk '/MemTotal/ {total=$2} /MemAvailable/ {available=$2} END {usage=((total-available)/total)*100; printf "Percent: %.2f%%\n", usage}' /proc/meminfo
awk '/MemTotal/ {total=$2} /MemAvailable/ {available=$2} END {printf "MiB: %d / %d MB\n", (total-available)/1024, total/1024}' /proc/meminfo

echo

#------------------------------------------------------------------------------

echo 'Internet Access Test:'

ping -c 1 1.1.1.1 > /dev/null && echo "Successful!" || echo "Failed!"

echo

#------------------------------------------------------------------------------

echo 'DNS Resolving Test:'

ping -c 1 cloudflare.com > /dev/null && echo "Successful!" || echo "Failed!"

echo

#------------------------------------------------------------------------------

echo '-------------------------------------------------------------------------'
echo

#------------------------------------------------------------------------------

echo '01: Pull updates from BOP-Repository on GitHub'
echo '02: Restart Nginx'
echo '03: Restart TOR'
echo '04: Restart Cloudflared'
echo '05: Reboot'
echo '06: Test Internet Connectivity'
echo '07: Test DNS Resolving'
echo '08: Restart Networking'
echo '09: Update OS'
echo '10: Exit to Shell'

echo
echo '-------------------------------------------------------------------------'
echo

#------------------------------------------------------------------------------

echo -e "What would you like to do? \n"
read -r action

#------------------------------------------------------------------------------


if [ "$action" = 1 ]; then
    bash /var/www/updates/merge.sh && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh
fi

if [ "$action" = 2 ]; then
    systemctl restart nginx | echo 'DONE' && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh
fi

if [ "$action" = 3 ]; then
    systemctl restart tor | echo 'DONE' && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh
fi

if [ "$action" = 4 ]; then
    systemctl restart cloudflared | echo 'DONE' && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh
fi

if [ "$action" = 5 ]; then
    reboot
fi

if [ "$action" = 6 ]; then
    ping -c 1 1.1.1.1 > /dev/null && echo "Successful!" || echo -e "Failed!\n" && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh
fi

if [ "$action" = 7 ]; then
    ping -c 1 cloudflare.com > /dev/null && echo "Successful!" || echo -e "Failed!\n" && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh
fi

if [ "$action" = 8 ]; then
    systemctl restart networking | echo 'DONE' && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh
fi

if [ "$action" = 9 ]; then
    echo 'Starting Update' && apt update && apt full-upgrade -y && apt autoremove -y && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh
fi


if [ "$action" = 10 ]; then
    bash
fi
