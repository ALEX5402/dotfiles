export scrDir="$(dirname "$(realpath "$0")")"
source "${scrDir}/globalcontrol.sh"

# Variables
current_wallpaper=$(readlink -f "${hydeThemeDir}/wall.set")
wallpaper_output="~/.cache/hyde/wall.set"
focused_monitor=$(hyprctl monitors | awk '/^Monitor/{name=$2} /focused: yes/{print name}')

# swww transition config
FPS=60
TYPE="wipe"
DURATION=2
BEZIER=".43,1.19,1,.4"
SWWW_PARAMS="--transition-fps $FPS --transition-type $TYPE --transition-duration $DURATION"

# Define ImageMagick effects
declare -A effects=(
    ["No Effects"]="no_effects"
    ["Black & White"]="magick $current_wallpaper -colorspace gray -sigmoidal-contrast 10,40% $wallpaper_output"
    ["Blurred"]="magick $current_wallpaper -blur 0x10 $wallpaper_output"
    ["Charcoal"]="magick $current_wallpaper -charcoal 0x5 $wallpaper_output"
    ["Edge Detect"]="magick $current_wallpaper -edge 1 $wallpaper_output"
    ["Emboss"]="magick $current_wallpaper -emboss 0x5 $wallpaper_output"
    ["Negate"]="magick $current_wallpaper -negate $wallpaper_output"
    ["Oil Paint"]="magick $current_wallpaper -paint 4 $wallpaper_output"
    ["Posterize"]="magick $current_wallpaper -posterize 4 $wallpaper_output"
    ["Polaroid"]="magick $current_wallpaper -polaroid 0 $wallpaper_output"
    ["Sepia Tone"]="magick $current_wallpaper -sepia-tone 65% $wallpaper_output"
    ["Solarize"]="magick $current_wallpaper -solarize 80% $wallpaper_output"
    ["Sharpen"]="magick $current_wallpaper -sharpen 0x5 $wallpaper_output"
    ["Vignette"]="magick $current_wallpaper -vignette 0x5 $wallpaper_output"
    ["Zoomed"]="magick $current_wallpaper -gravity Center -extent 1:1 $wallpaper_output"
)

# Function to apply no effects
no_effects() {
    swww img -o "$focused_monitor" "$current_wallpaper" $SWWW_PARAMS
}

# Function to run rofi menu
main() {
    # Populate rofi menu options
    options=("No Effects")
    for effect in "${!effects[@]}"; do
        [[ "$effect" != "No Effects" ]] && options+=("$effect")
    done

    # Show rofi menu and handle user choice
    choice=$(printf "%s\n" "${options[@]}" | LC_COLLATE=C sort | rofi -dmenu -p "Choose effect" -i -config ~/.config/rofi/config-wallpaper-effect.rasi)

    # Process user choice
    if [[ -n "$choice" ]]; then
        if [[ "$choice" == "No Effects" ]]; then
            no_effects
        elif [[ "${effects[$choice]+exists}" ]]; then
            # Apply selected effect
            eval "${effects[$choice]}"
            # Wait for effects to be applied
            sleep 1
            # Execute swww command after image conversion
#             swww img -o "$focused_monitor" "$wallpaper_output" $SWWW_PARAMS &
            swwwallpaper.sh
        else
            echo "Effect '$choice' not recognized."
        fi
    fi
}

# Check if rofi is already running and kill it
if pidof rofi > /dev/null; then
    pkill rofi
    exit 0
fi

main
