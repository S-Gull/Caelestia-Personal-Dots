#!/usr/bin/env bash
# Clipboard Manager for Caelestia Hyprland

rofi_theme="$HOME/.config/rofi/config-clipboard.rasi"
msg="↵ copiar   •   ctrl+del borrar   •   alt+del limpiar"

# Toggle: If rofi clipboard is already running, close it
if pidof rofi > /dev/null; then
    pkill rofi
    exit 0
fi

while true; do
    raw_list=$(cliphist list)
    if [ -z "$raw_list" ]; then
        notify-send -i edit-paste "Portapapeles" "El historial está vacío" -u low 2>/dev/null || true
        exit 0
    fi

    # Format list: strip ugly numeric ID and add nice iconography
    formatted_list=$(echo "$raw_list" | awk -F'\t' '{
        id = $1
        $1 = ""
        sub(/^[\t ]+/, "", $0)
        if ($0 ~ /^\[\[ binary data/) {
            print id "\t󰋩  " $0
        } else {
            print id "\t󰅌  " $0
        }
    }')

    # Show menu (displaying icons & content, using ID as hidden prefix for matching)
    selected=$(
        echo "$formatted_list" | rofi -i -dmenu \
            -p "󰅌" \
            -display-columns 2 \
            -kb-custom-1 "Control-Delete" \
            -kb-custom-2 "Alt-Delete" \
            -config "$rofi_theme" \
            -mesg "$msg"
    )

    status=$?

    case "$status" in
        1) # Escape / Cancel
            exit 0
            ;;
        0) # Item chosen -> Copy
            if [ -n "$selected" ]; then
                id="${selected%%	*}"
                printf "%s\t" "$id" | cliphist decode | wl-copy
                exit 0
            fi
            ;;
        10) # Ctrl + Delete -> Delete single item
            if [ -n "$selected" ]; then
                id="${selected%%	*}"
                printf "%s\t" "$id" | cliphist delete
            fi
            ;;
        11) # Alt + Delete -> Wipe entire clipboard
            cliphist wipe
            notify-send -i edit-clear-all "Portapapeles" "Historial vaciado correctamente" -u low 2>/dev/null || true
            exit 0
            ;;
        *)
            exit 0
            ;;
    esac
done
