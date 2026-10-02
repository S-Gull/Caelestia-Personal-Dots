#!/usr/bin/env bash
# /* ---- 💫 Hyprland Active Keybinds Cheat Sheet 💫 ---- */

BACKEND=wayland

# Check if rofi or yad or zenity is running and kill old instances
pkill yad 2>/dev/null || true
pkill zenity 2>/dev/null || true

ITEMS=(
"=== SISTEMA & LANZADORES ===" "" ""
"SUPER + H" "Guía de atajos rápida (Cheat Sheet)" "KeyHints.sh"
"SUPER + A" "Vista general de escritorios (Overview)" "OverviewToggle.sh"
"SUPER (o SUPER + D)" "Lanzador de aplicaciones" "caelestia:launcher"
"SUPER + N" "Barra lateral y notificaciones" "caelestia:sidebar"
"SUPER + K" "Mostrar todos los paneles" "caelestia:showall"
"CTRL + ALT + P (o CTRL + ALT + Del)" "Menú de apagado / Sesión" "caelestia:session"
"SUPER + J (o CTRL + ALT + L)" "Bloquear pantalla" "caelestia:lock"
"SUPER + SHIFT + J" "Bloquear e hibernar" "caelestia:lock + hibernate"
"CTRL + ALT + C" "Limpiar notificaciones" "caelestia:clearNotifs"

"=== APLICACIONES ===" "" ""
"SUPER + Enter" "Terminal principal" "kitty"
"SUPER + SHIFT + Enter" "Dropdown Terminal flotante" "kitty dropdown"
"SUPER + B" "Navegador Web" "firefox"
"SUPER + E" "Explorador de archivos" "nautilus"
"SUPER + C" "Editor de código" "antigravity"
"SUPER + ALT + B" "Gestor de Bluetooth" "blueman-manager"
"CTRL + ALT + V" "Control de volumen y audio" "pwvucontrol"

"=== CONTROL DE VENTANAS ===" "" ""
"SUPER + Q" "Cerrar ventana activa" "closewindow"
"SUPER + CTRL + Q" "Cerrar todas las ventanas del mismo tipo" "CloseAllOfType.sh"
"SUPER + SHIFT + Q" "Forzar cierre de proceso activo (Kill)" "KillActiveProcess.sh"
"ALT + Space" "Alternar ventana flotante / tiled" "togglefloating"
"SUPER + F" "Pantalla completa (Fake Fullscreen)" "fullscreen 1"
"SUPER + SHIFT + F" "Pantalla completa real (True Fullscreen)" "fullscreen 0"
"SUPER + SHIFT + G" "Agrupar ventanas (Group layout)" "togglegroup"
"SUPER + U" "Desagrupar ventana del grupo" "moveoutofgroup"
"SUPER + P" "Fijar ventana en pantalla (Pin)" "pin"
"SUPER + O" "Alternar ventana opaca / transparente" "opaque"

"=== NAVEGACIÓN & WORKSPACES ===" "" ""
"SUPER + Flechas" "Mover foco (Izquierda, Derecha, Arriba, Abajo)" "focuswindow"
"SUPER + SHIFT + Izq/Der" "Mover ventana a la izquierda o derecha" "movewindow"
"SUPER + S" "Mostrar / Ocultar cajón especial (Scratchpad)" "specialws"
"SUPER + SHIFT + Arriba" "Meter ventana activa al cajón especial" "movetoworkspace special"
"SUPER + SHIFT + Abajo" "Sacar ventana del cajón al escritorio normal" "movetoworkspace normal"
"SUPER + 1..10" "Ir al espacio de trabajo (Workspace 1 al 10)" "workspace 1..10"
"SUPER + ALT + 1..10" "Mover ventana activa al Workspace 1 al 10" "movetoworkspace"
"ALT + Tab" "Ciclar a la siguiente ventana" "cycle_next"
"SHIFT + ALT + Tab" "Ciclar a la ventana anterior" "cycle_prev"
"SUPER + Tab" "Ciclar historial de espacios (1 tap = previo / mantener = navegar todo)" "cycle_workspace(1)"
"SUPER + SHIFT + Tab" "Ciclar historial de espacios hacia atrás" "cycle_workspace(-1)"

"=== UTILIDADES & CAPTURA ===" "" ""
"SUPER + V" "Historial del portapapeles (Copiar/Borrar)" "ClipManager.sh"
"SUPER + Period (.)" "Selector de emojis" "caelestia emoji"
"SUPER + SHIFT + S" "Captura de pantalla (Congelada / Freeze)" "caelestia:screenshotFreeze"
"Print" "Captura de pantalla estándar" "caelestia:screenshot"
"CTRL + ALT + R" "Grabar pantalla completa" "caelestia record"
"SUPER + ALT + R" "Grabar sonido del sistema" "caelestia record -s"
"SUPER + SHIFT + ALT + R" "Grabar región seleccionada" "caelestia record -r"
"SUPER + SHIFT + C" "Selector de color en pantalla (Gotero)" "hyprpicker"

"=== APARIENCIA & TECLADO ===" "" ""
"SUPER + G" "Alternar Modo Juego (desactivar animaciones)" "GameMode.sh"
"SUPER + SHIFT + O" "Alternar desenfoque (Blur)" "ChangeBlur.sh"
"SUPER + W" "Configuraciones de Caelestia (Nexus)" "caelestia:nexus"
"SUPER + ALT + W" "Seleccionar fondo de pantalla" "WallpaperSelect.sh"
"SUPER + SHIFT + W" "Efectos en fondo de pantalla" "WallpaperEffects.sh"
"CTRL + ALT + W" "Fondo de pantalla aleatorio" "WallpaperRandom.sh"
"SUPER + Space" "Cambiar distribución de teclado (Global)" "SwitchKeyboardLayout.sh"
"SUPER + SHIFT + Space" "Cambiar distribución de teclado (Por ventana)" "Tak0-Per-Window-Switch.sh"
)

if command -v yad >/dev/null 2>&1; then
    GDK_BACKEND=$BACKEND yad \
        --center \
        --title="Hyprland Cheat Sheet" \
        --width=800 \
        --height=600 \
        --no-buttons \
        --list \
        --column="Tecla / Atajo" \
        --column="Descripción" \
        --column="Comando / Acción" \
        --timeout-indicator=bottom \
        "${ITEMS[@]}"
elif command -v zenity >/dev/null 2>&1; then
    zenity --list \
        --title="Hyprland Cheat Sheet — Atajos Activos" \
        --width=820 \
        --height=620 \
        --column="Atajo" \
        --column="Descripción" \
        --column="Acción" \
        "${ITEMS[@]}"
fi
exit 0
