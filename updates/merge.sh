
echo "Cloning BytesOfProgress repository from GitHub..."
git clone https://github.com/5calV/BytesOfProgress

mv BytesOfProgress /var/www

echo "Replacing the old website files..."
rm -rf /var/www/*

mv /var/www/BytesOfProgress/* /var/www/

echo "Removing repository"
rm -rf /var/www/BytesOfProgress

chmod +x /var/www/maintenance/BOP-system-util.sh

echo "DONE!"
