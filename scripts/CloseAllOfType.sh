#!/usr/bin/env bash
# Script para cerrar todas las ventanas y procesos de la misma clase que la ventana activa

active_win=$(hyprctl activewindow -j)
active_class=$(echo "$active_win" | jq -r '.class // empty')
active_initial_class=$(echo "$active_win" | jq -r '.initialClass // empty')

# Si no hay ventana activa o clase
if [[ -z "$active_class" || "$active_class" == "null" ]]; then
  exit 0
fi

# PROTECCIÓN: Jamás cerrar Antigravity IDE
if [[ "$active_class" =~ antigravity || "$active_initial_class" =~ antigravity ]]; then
  notify-send -u low "Protección" "Antigravity IDE está protegido y no se cerrará."
  exit 0
fi

# Obtener direcciones y PIDs de todas las ventanas con la misma clase
matching_windows=$(hyprctl clients -j | jq -r --arg c "$active_class" --arg ic "$active_initial_class" \
  '.[] | select(.class == $c or .initialClass == $ic) | "\(.address) \(.pid)"')

if [[ -z "$matching_windows" ]]; then
  exit 0
fi

# 1. Cerrar ordenadamente cada ventana a través de Hyprland
while read -r addr pid; do
  if [[ -n "$addr" && "$addr" != "null" ]]; then
    hyprctl dispatch closewindow "address:$addr"
  fi
done <<< "$matching_windows"

# 2. Breve espera para que los procesos terminen su guardado/cierre
sleep 0.25

# 3. Si queda algún proceso rezagado de esa clase, terminarlo
while read -r addr pid; do
  if [[ -n "$pid" && "$pid" =~ ^[0-9]+$ && "$pid" -gt 1 ]]; then
    if kill -0 "$pid" 2>/dev/null; then
      kill -9 "$pid" 2>/dev/null
    fi
  fi
done <<< "$matching_windows"

notify-send -u low -t 1500 "Ventanas cerradas" "Se cerraron todas las instancias de: $active_class"
