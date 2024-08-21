#!/bin/sh

echo "Content-Type: text/html"
echo ""
echo "<!DOCTYPE html>"
echo "<html lang=\"de\">"
echo "<head>"
echo "  <meta charset=\"UTF-8\">"
echo "  <title>BOP Admin Panel</title>"
echo "  <link rel=\"icon\" type=\"image/x-icon\" href=\"/assets/favicon.png\">"
echo "  <style>"
echo "    body { font-family: Arial, sans-serif; color: #ffffff; background-color: #000000; }"
echo "    .section { margin-bottom: 20px; }"
echo "    .section h2 { margin: 0; }"
echo "    pre { color: #ffffff; font-size: 14px; white-space: pre-wrap; }"
echo "  </style>"
echo "</head>"
echo "<body>"

# CPU Temperature
echo "<div class='section'>"
echo "<h2>CPU Temperature:</h2>"
if command -v sensors >/dev/null 2>&1; then
  echo "<pre>$(sensors | grep Core | awk '{print $1, $2, $3}')</pre>"
else
  echo "<p>Command 'sensors' not available.</p>"
fi
echo "</div>"

# CPU Usage
echo "<div class='section'>"
echo "<h2>CPU Usage:</h2>"
echo "<pre>"
(
  # First measurement
  awk '/^cpu[0-9]+/ {print $1, $2+$3+$4+$5+$6, $5}' /proc/stat > /tmp/stat1
  sleep 1
  # Second measurement
  awk '/^cpu[0-9]+/ {print $1, $2+$3+$4+$5+$6, $5}' /proc/stat > /tmp/stat2

  # Calculation & Output
  awk '
    NR==FNR {
      idle_before[$1]=$3
      total_before[$1]=$2
      next
    }
    /^cpu[0-9]+/ {
      idle[$1]=$3
      total[$1]=$2
      if (length(idle_before[$1])) {
        idle_diff = idle[$1] - idle_before[$1]
        total_diff = total[$1] - total_before[$1]
        usage = (total_diff > 0) ? (100 * (1 - (idle_diff / total_diff))) : 0
        core = substr($1, 4)
        printf "Core %d: %.1f%%\n", core, usage
      }
    }' /tmp/stat1 /tmp/stat2
)
echo "</pre>"
echo "</div>"

# RAM Usage
echo "<div class='section'>"
echo "<h2>RAM Usage:</h2>"
echo "<pre>"
echo "$(awk '/MemTotal/ {total=$2} /MemAvailable/ {available=$2} END {usage=((total-available)/total)*100; printf "Percent: %.2f%%\n", usage}' /proc/meminfo)"
echo "$(awk '/MemTotal/ {total=$2} /MemAvailable/ {available=$2} END {printf "MiB: %d / %d MiB\n", (total-available)/1024, total/1024}' /proc/meminfo)"
echo "</pre>"
echo "</div>"

# Disk Usage
echo "<div class='section'>"
echo "<h2>Disk Usage:</h2>"
echo "<pre>"
df -h --total | grep 'total' | awk '{used=$3; total=$2; sub(/G/, "", used); sub(/G/, " GiB", total); percent=(used/total)*100; printf "Percent: %.1f%%\nGiB: %.1f / %s\n", percent, used, total}'
echo "</pre>"
echo "</div>"

# Uptime
echo "<div class='section'>"
echo "<h2>Uptime:</h2>"
echo "<pre>$(uptime -p | sed 's/up //')</pre>"
echo "</div>"

echo "</body>"
echo "</html>"

# Removing temporary files.
rm /tmp/stat1 /tmp/stat2
