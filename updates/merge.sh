
echo "Cloning BytesOfProgress repository from GitHub..."

rm -rf /var/www/*

git clone https://github.com/5calV/BytesOfProgress

mv BytesOfProgress/* /var/www/

echo "Replacing the old website files..."

mkdir /var/www/management

cp /var/www/maintenance/management-panel/* /var/www/management/

echo "Removing repository"
rm -rf /var/www/BytesOfProgress

chmod +x /var/www/maintenance/BOP-system-util.sh

echo "DONE!"
