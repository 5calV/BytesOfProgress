#!/bin/sh

echo "Content-Type: text/html"
echo ""
echo "<!DOCTYPE html>"
echo "<html lang=\"de\">"
echo "<head>"
echo "  <meta charset=\"UTF-8\">"
echo "  <title>BOP Admin Panel</title>"
echo "    <link rel=\"icon\" type=\"image/x-icon\" href=\"/assets/favicon.png\">"
echo "    <style>"
echo "        body { font-family: Arial, sans-serif; color: #ffffff; background-color: #000000; }"
echo "        .section { margin-bottom: 20px; }"
echo "        .section h2 { margin: 0; }"
echo "        pre { color: #ffffff; }"
echo "    </style>"
echo "</head>"
echo "<body>"

# CPU Temperature
echo "<div class='section'>"
echo "<h2>CPU Temperature:</h2>"
if command -v sensors >/dev/null 2>&1; then
    echo "<pre>$(sensors | grep Core)</pre>"
else
    echo "<p>Command 'sensors' not available.</p>"
fi
echo "</div>"

# CPU Usage
echo "<div class='section'>"
echo "<h2>CPU Usage:</h2>"
echo "<pre>$(grep -E '^cpu[0-9]+ ' /proc/stat | awk 'NR <= 2 {usage=($2+$4)*100/($2+$4+$5+$6)} {print "Core " NR-1 ": " usage "%"}')</pre>"
echo "</div>"

# RAM Usage
echo "<div class='section'>"
echo "<h2>RAM Usage:</h2>"
echo "<pre>"
echo "$(awk '/MemTotal/ {total=$2} /MemAvailable/ {available=$2} END {usage=((total-available)/total)*100; printf "Percent: %.2f%%\n", usage}' /proc/meminfo)"
echo "$(awk '/MemTotal/ {total=$2} /MemAvailable/ {available=$2} END {printf "MiB: %d / %d MB\n", (total-available)/1024, total/1024}' /proc/meminfo)"
echo "</pre>"
echo "</div>"

# Uptime
echo "<div class='section'>"
echo "<h2>Uptime:</h2>"
echo "<pre>$(uptime -p | sed 's/up //')</pre>"
echo "</div>"

echo "</body>"
echo "</html>"