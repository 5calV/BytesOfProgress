
echo "Cloning BytesOfProgress repository from GitHub..."

rm -rf /var/www/*

git clone https://github.com/5calV/BytesOfProgress

mkdir /var/temp

mv BytesOfProgress /var/temp

mv /var/temp/BytesOfProgress/* /var/www/

echo "Replacing the old website files..."

echo "Removing repository"
rm -rf /var/temp

chmod +x /var/www/maintenance/BOP-system-util.sh

rm /usr/lib/cgi-bin/monitoring.sh

cp /var/www/maintenance/management-panel/monitoring.sh /usr/lib/cgi-bin/monitoring.sh

echo "DONE!"
