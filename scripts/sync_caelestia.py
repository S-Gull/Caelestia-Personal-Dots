import os, time, sys

CURRENT_LUA = os.path.expanduser("~/.config/hypr/scheme/current.lua")
ROFI_PALETTE = os.path.expanduser("~/.config/rofi/caelestia-colors.rasi")
KITTY_THEME = os.path.expanduser("~/.config/kitty/current-theme.conf")

def h2rgb(hex_str):
    hex_str = hex_str.lstrip("#")
    if len(hex_str) < 6:
        hex_str = hex_str.ljust(6, "0")
    return int(hex_str[0:2], 16), int(hex_str[2:4], 16), int(hex_str[4:6], 16)

def hex_to_rgba(hex_str, alpha):
    r, g, b = h2rgb(hex_str)
    return f"rgba({r}, {g}, {b}, {alpha})"

def sync():
    if not os.path.exists(CURRENT_LUA):
        return

    vars = {}
    try:
        with open(CURRENT_LUA, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if "=" in line and not line.startswith("--"):
                    parts = line.split("=", 1)
                    k = parts[0].strip()
                    v = parts[1].strip().strip(",").strip('"').strip("'")
                    vars[k] = v
    except Exception:
        return

    if not vars:
        return

    bg_raw = vars.get("background", "18120e").lstrip("#")
    surface_raw = vars.get("surfaceContainer", vars.get("surface", "241e1a")).lstrip("#")
    surface_high_raw = vars.get("surfaceContainerHighest", "3a332e").lstrip("#")
    primary_raw = vars.get("primary", "ffb878").lstrip("#")
    text_raw = vars.get("onSurface", vars.get("text", "ece0d9")).lstrip("#")
    muted_raw = vars.get("onSurfaceVariant", vars.get("subtext1", "d6c3b5")).lstrip("#")
    outline_raw = vars.get("outline", "9f8e81").lstrip("#")

    bg_hex = "#" + bg_raw
    surface_high_hex = "#" + surface_high_raw
    primary_hex = "#" + primary_raw
    text_hex = "#" + text_raw
    muted_hex = "#" + muted_raw
    outline_hex = "#" + outline_raw

    bg_glass = hex_to_rgba(bg_raw, 0.85)
    surface_glass = hex_to_rgba(surface_raw, 0.88)
    surface_high_glass = hex_to_rgba(surface_high_raw, 0.65)
    primary_alpha = hex_to_rgba(primary_raw, 0.22)
    primary_dim = hex_to_rgba(primary_raw, 0.40)
    outline_glass = hex_to_rgba(outline_raw, 0.25)

    rofi_content = f"""/* Caelestia Dynamic Palette for Rofi (Auto-generated) */
* {{
    caelestia-bg:            {bg_glass};
    caelestia-surface:       {surface_glass};
    caelestia-surface-high:  {surface_high_glass};
    caelestia-primary:       {primary_hex};
    caelestia-primary-alpha: {primary_alpha};
    caelestia-primary-dim:   {primary_dim};
    caelestia-text:          {text_hex};
    caelestia-muted:         {muted_hex};
    caelestia-outline:       {outline_glass};
}}
"""
    with open(ROFI_PALETTE, "w", encoding="utf-8") as f:
        f.write(rofi_content)

    term = [vars.get(f"term{i}", "ffffff").lstrip("#") for i in range(16)]
    kitty_content = f"""# Caelestia Auto-generated Kitty Theme
background            {bg_hex}
foreground            {text_hex}
cursor                {primary_hex}
selection_background  {surface_high_hex}
selection_foreground  {text_hex}

color0                #{term[0]}
color8                #{term[8]}
color1                #{term[1]}
color9                #{term[9]}
color2                #{term[2]}
color10               #{term[10]}
color3                #{term[3]}
color11               #{term[11]}
color4                #{term[4]}
color12               #{term[12]}
color5                #{term[5]}
color13               #{term[13]}
color6                #{term[6]}
color14               #{term[14]}
color7                #{term[7]}
color15               #{term[15]}

active_tab_foreground   #{term[15]}
active_tab_background   {surface_high_hex}
inactive_tab_foreground {muted_hex}
inactive_tab_background {bg_hex}
"""
    with open(KITTY_THEME, "w", encoding="utf-8") as f:
        f.write(kitty_content)

    # Also sync Quickshell Overview colors if it exists
    qs_app = os.path.expanduser('~/.config/quickshell/overview/common/Appearance.qml')
    if os.path.exists(qs_app):
        try:
            with open(qs_app, 'r') as f:
                content = f.read()
            import re
            m3_map = {
                'm3primary': primary_hex,
                'm3background': bg_hex,
                'm3surface': bg_hex,
                'm3surfaceContainer': '#' + surface_raw,
                'm3surfaceContainerHighest': surface_high_hex,
                'm3onSurface': text_hex,
                'm3onBackground': text_hex,
                'm3outline': outline_hex,
            }
            for prop, val in m3_map.items():
                content = re.sub(rf'property color {prop}: ".*?"', f'property color {prop}: "{val}"', content)
            with open(qs_app, 'w') as f:
                f.write(content)
        except Exception:
            pass


    os.system("kill -SIGUSR1 $(pidof kitty) 2>/dev/null")

if __name__ == "__main__":
    sync()
    last_val = None
    while True:
        try:
            with open(CURRENT_LUA, "r") as f:
                content = f.read()
            if last_val is not None and content != last_val:
                sync()
            last_val = content
        except Exception:
            pass
        time.sleep(0.3)
