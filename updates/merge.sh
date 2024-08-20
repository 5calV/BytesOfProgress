
echo "Cloning BytesOfProgress repository from GitHub..."

rm -rf /var/www/*

git clone https://github.com/5calV/BytesOfProgress

mkdir /var/temp

mv BytesOfProgress /var/temp

mv /var/temp/BytesOfProgress/* /var/www/

echo "Replacing the old website files..."

# Permission for CPU calculation (CGI).
chmod 1777 /tmp

echo "Removing repository"
rm -rf /var/temp

chmod +x /var/www/maintenance/BOP-system-util.sh

echo "DONE!"
