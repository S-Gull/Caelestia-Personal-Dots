#!/usr/bin/env bash

# Alternar distribución de teclado en Hyprland
hyprctl switchxkblayout all next >/dev/null 2>&1

# Obtener la distribución activa del teclado principal
active_layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.main == true) | .active_keymap // empty')

if [[ -z "$active_layout" ]]; then
  active_layout=$(hyprctl devices -j | jq -r '.keyboards[0].active_keymap // "Spanish"')
fi

# Notificación toast nativa en la parte inferior de Caelestia
caelestia shell toaster info "Keyboard layout changed" "Layout changed to: $active_layout" "keyboard"
