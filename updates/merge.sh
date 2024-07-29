
echo "Cloning BytesOfProgress repository from GitHub..."

rm -rf /var/www/*

git clone https://github.com/5calV/BytesOfProgress

mv BytesOfProgress /var/www

rm /usr/lib/cgi-bin/monitoring.sh

mv /var/www/installation/management-panel/monitoring.sh /usr/lib/cgi-bin/monitoring.sh

echo "Replacing the old website files..."

mv /var/www/BytesOfProgress/* /var/www/

mkdir /var/www/management

cp /var/www/installation/management-panel/* /var/www/management/

echo "Removing repository"
rm -rf /var/www/BytesOfProgress

chmod +x /var/www/maintenance/BOP-system-util.sh

echo "DONE!"
