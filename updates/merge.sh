
echo "Cloning BytesOfProgress repository from GitHub..."

rm -rf /var/www/*

git clone https://github.com/5calV/BytesOfProgress

mv BytesOfProgress /var/www

echo "Replacing the old website files..."

mv /var/www/BytesOfProgress/* /var/www/

echo "Removing repository"
rm -rf /var/www/BytesOfProgress

chmod +x /var/www/maintenance/BOP-system-util.sh

#-------------------------------------------------------------------------------

rm -rf /var/BOP-discord/*

mv /var/www/discord-bot/BOP-BOT.py /var/BOP-discord/BOP-BOT.py

cat /var/BOP-secrets/discordbot/DC-BOT-Token.txt >> /var/BOP-discord/BOP-BOT.py

python3 /var/BOP-discord/BOP-BOT.py > /dev/null 2>&1

#-------------------------------------------------------------------------------



echo "DONE!"
