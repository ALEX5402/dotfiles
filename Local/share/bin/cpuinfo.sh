#!/usr/bin/env sh

# CPU model
model=$(grep -m 1 'model name' /proc/cpuinfo | awk -F ': ' '{print $2}')

# CPU utilization
utilization=$(top -bn1 | awk '/^%Cpu/ {print 100 - $8}')

# Clock speed
freqlist=$(grep "cpu MHz" /proc/cpuinfo | awk '{ print $4 }')
maxfreq=$(($(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq) / 1000))
frequency=$(echo "$freqlist" | awk '{ sum+=$1 } END {printf "%.0f/%d MHz", sum/NR, maxfreq}')

# CPU temperature
temp=$(sensors | awk '/Package id 0/ {print $4}' | awk -F '[+.]' '{print $2}')
if [ -z "$temp" ]; then
    temp=$(sensors | awk '/Tctl/ {print $2}' | tr -d '+°C')
fi
[ -z "$temp" ] && temp="N/A"

# Convert temperature to integer (strip decimal part)
temp_int=$(echo "$temp" | awk -F '.' '{print $1}')

# Icon mapping function
eval_ico() {
    local aky="$1"
    local avl="$2"
    local map_ico=$(jq -r --arg aky "$aky" --argjson avl "$avl" '.[$aky] | keys_unsorted | map(tonumber) | map(select(. <= $avl)) | max' <<< "$set_ico")
    jq -r --arg aky "$aky" --arg avl "$map_ico" '.[$aky] | .[$avl]' <<< "$set_ico"
}

# Icon map JSON
set_ico='{
    "thermo":{"0":"","45":"","65":"","85":""},
    "emoji":{"0":"❄️","45":"☁️","65":"🔥","85":"🌋"},
    "util":{"0":"󰾆","30":"󰾅","60":"󰓅","90":""}
}'

# Evaluate icons based on temperature and utilization
thermo=$(eval_ico thermo "$temp_int")
emoji=$(eval_ico emoji "$temp_int")
speedo=$(eval_ico util "$utilization")

# Notification function using hyprctl
send_notification() {
    local temp="$1"
    local emoji="$2"
#     hyprctl notify 2 1500 "rgb(E5BD49)" "fontsize:20 ${emoji} High CPU Temperature: ${temp}°C"
      notify-send -t 1500 -i ~/.config/dunst/icons/cpu-fire.svg "${emoji} High CPU Temperature" "Current temperature: ${temp}°C"

}

# Send notification if temperature exceeds 70°C
if [ "$temp_int" != "N/A" ] && [ "$temp_int" -gt 75 ]; then
    send_notification "$temp" "$emoji"
fi

# Output JSON
echo "{\"text\":\"${thermo} ${temp}°C\", \"tooltip\":\"${model}\n${thermo} Temperature: ${temp}°C ${emoji}\n${speedo} Utilization: ${utilization}%\n Clock Speed: ${frequency}\"}"
