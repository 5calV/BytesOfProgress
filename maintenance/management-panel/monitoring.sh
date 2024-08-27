#!/bin/sh

echo "Content-Type: text/html"
echo ""
echo "<!DOCTYPE html>"
echo "<html lang=\"de\">"
echo "<head>"
echo "  <meta charset=\"UTF-8\">"
echo "  <style>"
echo "    body { font-family: Arial, sans-serif; color: #ffffff; background-color: #000000; margin: 0; padding: 0; }"
echo "    .container { display: flex; flex-wrap: wrap; padding: 20px; }"
echo "    .box { background: #333333 !important; border-radius: 8px !important; padding: 15px; margin: 10px; flex: 1; min-width: calc(50% - 40px); box-shadow: 0 4px 8px rgba(0, 0, 0, 0.5); position: relative; }"
echo "    .box h2 { margin: 0 0 10px 0; }"
echo "    .box pre { color: #ffffff; font-size: 14px; white-space: pre-wrap; margin: 0; }"
echo "    .bar { height: 20px !important; background: #555555; border-radius: 8px; overflow: hidden; position: relative; margin-top: 10px; }"
echo "    .bar span { display:inline-block; height: 100%; background: #00ff00; position: absolute; top: 0; left: 0; }"
echo "    .bar-text { position: absolute; width: 100%; text-align: center; color: #ffffff; line-height: 20px; font-size: 12px; }"
echo "  </style>"
echo "</head>"
echo "<body>"

# Container div
echo "<div class='container'>"

# CPU Temperature
echo "<div class='box'>"
echo "<pre>CPU Temperature:</pre>"
if command -v sensors >/dev/null 2>&1; then
  echo "<pre>$(sensors | grep Core | awk '{print $1, $2, $3}')</pre>"
else
  echo "<p>Command 'sensors' not available.</p>"
fi
echo "</div>"

# CPU Usage
echo "<div class='box'>"
echo "<pre>CPU Usage:</pre>"
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
echo "<div class='bar'><span style='width: $(awk '/^cpu[0-9]+/ {idle[$1]=$3; total[$1]=$2} END {idle_diff = idle["cpu"] - idle_before["cpu"]; total_diff = total["cpu"] - total_before["cpu"]; usage = (total_diff > 0) ? (100 * (1 - (idle_diff / total_diff))) : 0; printf \"%.1f\", usage}' /tmp/stat2)%'></span><div class='bar-text'>$(awk '/^cpu[0-9]+/ {idle[$1]=$3; total[$1]=$2} END {idle_diff = idle["cpu"] - idle_before["cpu"]; total_diff = total["cpu"] - total_before["cpu"]; usage = (total_diff > 0) ? (100 * (1 - (idle_diff / total_diff))) : 0; printf \"%.1f%%\", usage}' /tmp/stat2)</div></div>"
echo "</div>"

# RAM Usage
echo "<div class='box'>"
echo "<pre>RAM Usage:</pre>"
echo "<pre>"
awk '/MemTotal/ {total=$2} /MemAvailable/ {available=$2} END {used=total-available; usage=(used/total)*100; printf "Percent: %.2f%%\nMiB: %d / %d MiB\n", usage, used/1024, total/1024}' /proc/meminfo
echo "</pre>"
echo "</div>"

# Disk Usage
echo "<div class='box'>"
echo "<pre>Disk Usage:</pre>"
echo "<pre>"
disk_usage=$(df -h --total | grep 'total' | awk '{used=$3; total=$2; sub(/G/, "", used); sub(/G/, " GiB", total); percent=(used/total)*100; printf "Percent: %.1f%%\nGiB: %.1f / %s\n", percent, used, total}')
echo "$disk_usage"
echo "</pre>"
echo "</div>"

# Uptime
echo "<div class='box'>"
echo "<pre>Uptime:</pre>"
echo "<pre>TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTEST</pre>"
echo "</div>"

echo "</div>"
echo "</body>"
echo "</html>"

# Removing temporary files.
rm /tmp/stat1 /tmp/stat2
