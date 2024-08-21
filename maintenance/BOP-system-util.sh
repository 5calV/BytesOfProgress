#!/bin/bash

# ---------------------------------------------------------------------------------------------------------------------------------

# ╭∩╮      ╭∩╮
#  \(͡⚈ᴗ͡⚈)/

# ---------------------------------------------------------------------------------------------------------------------------------

clear

echo 'Welcome to BytesOfProgress System Utility!'

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

sleep 0.5

echo 'You can always start this utility by typing "bop"!'

echo

sleep 1

#------------------------------------------------------------------------------

echo 'CPU Temperature:'

sensors | grep Core | awk '{print $1, $2, $3}'

echo

#------------------------------------------------------------------------------

awk 'BEGIN {print "CPU Usage:"}
  /^cpu[0-9]+/ {
    idle[$1]=$5;
    total[$1]=$2+$3+$4+$5+$6;
    if (NR==FNR) {
      idle_before[$1]=idle[$1];
      total_before[$1]=total[$1];
      next;
    }
    idle_diff = idle[$1] - idle_before[$1];
    total_diff = total[$1] - total_before[$1];
    usage = (total_diff > 0) ? (100 * (1 - (idle_diff / total_diff))) : 0;
    core = substr($1, 4);
    printf "Core %d: %.1f%%\n", core, usage;
  }' /proc/stat <(sleep 1; cat /proc/stat)


echo

#------------------------------------------------------------------------------

echo 'RAM Usage:'

awk '/MemTotal/ {total=$2} /MemAvailable/ {available=$2} END {usage=((total-available)/total)*100; printf "Percent: %.2f%%\n", usage}' /proc/meminfo
awk '/MemTotal/ {total=$2} /MemAvailable/ {available=$2} END {printf "MiB: %d / %d MiB\n", (total-available)/1024, total/1024}' /proc/meminfo

echo

echo 'Disk Usage:'

df -h --total | grep 'total' | awk '{used=$3; total=$2; sub(/G/, "", used); sub(/G/, " GiB", total); percent=(used/total)*100; printf "Percent: %.1f%%\nGiB: %.1f / %s\n", percent, used, total}'

echo

#------------------------------------------------------------------------------

echo "You are logged in as: $(whoami)"

echo

#------------------------------------------------------------------------------

echo "Uptime: $(uptime -p | sed 's/up //')"
echo

#------------------------------------------------------------------------------

echo '-------------------------------------------------------------------------'
echo

#------------------------------------------------------------------------------

echo '01: Pull updates from BOP-Repository on GitHub ( root only )'
echo '02: Restart Nginx ( root only )'
echo '03: Restart Cloudflared ( root only )'
echo '04: Reboot ( root only )'
echo '05: Test Internet Connectivity'
echo '06: Test DNS Resolving'
echo '07: Restart Networking ( root only )'
echo '08: Update OS ( root only )'
echo '09: Start HTOP'
echo '10: Start IFTOP'
echo '11: Restart TOR'
echo '12: Start Nyx'

echo '13: Restart Utility as root'
echo '14: Exit to Shell'

echo
echo '-------------------------------------------------------------------------'
echo

#------------------------------------------------------------------------------

echo -e "What would you like to do? \n"
read -r action

#------------------------------------------------------------------------------

if [ "$action" = 1 ]; then
    bash /var/www/maintenance/updates/git-update.sh && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh

elif [ "$action" = 2 ]; then
    systemctl restart nginx | echo 'DONE' && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh

elif [ "$action" = 3 ]; then
    systemctl restart cloudflared | echo 'DONE' && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh

elif [ "$action" = 4 ]; then
    reboot

elif [ "$action" = 5 ]; then
    ping -c 1 1.1.1.1 > /dev/null && echo "Successful!" || echo -e "Failed!\n" && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh

elif [ "$action" = 6 ]; then
    ping -c 1 cloudflare.com > /dev/null && echo "Successful!" || echo -e "Failed!\n" && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh

elif [ "$action" = 7 ]; then
    systemctl restart networking | echo 'DONE' && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh

elif [ "$action" = 8 ]; then
    echo 'Starting Update' && apt update && apt full-upgrade -y && apt autoremove -y && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh

elif [ "$action" = 9 ]; then
    htop && bash /var/www/maintenance/BOP-system-util.sh

elif [ "$action" = 10 ]; then
    iftop && bash /var/www/maintenance/BOP-system-util.sh

elif [ "$action" = 11 ]; then
    systemctl restart tor | echo 'DONE' && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh

elif [ "$action" = 12 ]; then
    nyx && bash /var/www/maintenance/BOP-system-util.sh















elif [ "$action" = 13 ]; then
  su -c "/bin/bash /var/www/maintenance/BOP-system-util.sh"

elif [ "$action" = 14 ]; then
    bash

else
    echo "Invalid Input!" && sleep 3 && bash /var/www/maintenance/BOP-system-util.sh
fi
