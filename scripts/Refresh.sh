#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for refreshing hyprpanel, rofi, wallust

SCRIPTSDIR=$HOME/.config/hypr/scripts
UserScripts=$HOME/.config/hypr/UserScripts

# Define file_exists function
file_exists() {
  if [ -e "$1" ]; then
    return 0 # File exists
  else
    return 1 # File does not exist
  fi
}

# Kill already running processes
_ps=(rofi ags)
for _prs in "${_ps[@]}"; do
  if pidof "${_prs}" >/dev/null; then
    pkill "${_prs}"
  fi
done

# Quit hyprpanel — its bash wrapper hides it from pidof/pkill, so use astal
if command -v astal >/dev/null 2>&1 && astal -l 2>/dev/null | grep -qx hyprpanel; then
  astal -q -i hyprpanel >/dev/null 2>&1 || true
else
  pkill -f "/usr/share/hyprpanel/hyprpanel-app" >/dev/null 2>&1 || true
fi

# Added sleep
sleep 0.3

# Restart Caelestia shell
if command -v caelestia >/dev/null 2>&1; then
  caelestia shell -r >/dev/null 2>&1 &
else
  pkill qs 2>/dev/null || true
  sleep 0.2
  caelestia shell -d >/dev/null 2>&1 &
fi

# Ensure quickshell overview is also running
if ! pgrep -f "qs -c overview" >/dev/null 2>&1; then
  qs -c overview -d >/dev/null 2>&1 &
fi

# Relaunching rainbow borders if the script exists
sleep 1
if file_exists "${UserScripts}/RainbowBorders.sh"; then
  ${UserScripts}/RainbowBorders.sh &
fi

exit 0
