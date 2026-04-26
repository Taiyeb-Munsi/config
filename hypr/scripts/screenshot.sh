#!/usr/bin/env bash

DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"

GEOM=$(slurp)
[ -z "$GEOM" ] && exit 1

THEME='
*{
    font: "JetBrains Mono 12";

}

window {
    width: 120px;
    border-radius: 8px;
    padding: 6px;
}

element {
    padding: 0px;
}

inputbar {
    enabled: false;
}

listview {
    spacing: 2px;
    padding: 0px;
    lines: 2;
    fixed-height: true;
    show-icons: false;
}

element-icon {
    size: 0px;
    padding: 0px;
    margin: 0px;
}
'

CHOICE=$(printf "copy\nsave" | rofi -dmenu -p "Screenshot" -theme-str "$THEME")

sleep 0.2

case "$CHOICE" in
    copy)
        grim -g "$GEOM" - | wl-copy
        grim -g "$GEOM" - | cliphist store
        notify-send -t 2000 "Screenshot" "Copied to clipboard"
        ;;
    save)
        FILE="$DIR/screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"
        grim -g "$GEOM" "$FILE"
        notify-send -t 2000 "Screenshot" "Saved $FILE"
        ;;
esac
