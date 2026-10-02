local vars = require("variables")
local fn   = require("utils.functions")

hl.on("hyprland.start", function()
    -- Keyring and auth
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
    hl.exec_cmd("test -f /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 && /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 || /usr/lib/polkit-kde-authentication-agent-1")

    -- Clipboard history
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Auto delete trash 30 days old
    hl.exec_cmd("trash-empty 30")

    -- Cursors and Icons
    hl.exec_cmd("hyprctl setcursor " .. vars.cursorTheme .. " " .. vars.cursorSize)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme " .. vars.cursorTheme)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size " .. vars.cursorSize)
    if vars.iconTheme then
        hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme " .. vars.iconTheme)
    end

    -- Location provider and night light
    hl.exec_cmd("/usr/lib/geoclue-2.0/demos/agent")
    hl.exec_cmd("sleep 1 && gammastep")

    -- Forward bluetooth media commands to MPRIS
    hl.exec_cmd("mpris-proxy")
    hl.exec_cmd("blueman-applet")

    -- EasyEffects daemon for audio and microphone processing in background
    hl.exec_cmd("easyeffects --service-mode")

    -- Sync Caelestia color scheme with Rofi and Kitty in real time
    hl.exec_cmd("~/.config/hypr/scripts/SyncCaelestiaThemes.sh")

    -- Ensure portals and systemd have wayland environment
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Start shell and overview
    hl.exec_cmd("caelestia shell -d")
    hl.exec_cmd("qs -c overview -d")
end)

-- Resizer listeners
local function apply_resizer_rules(win)
    local float_center = {
        hl.dsp.window.float({ action = "on", window = win }),
        hl.dsp.window.center({ window = win }),
    }
    local pip_actions = fn.move_actions(win) or {}

    -- Bitwarden
    fn.resizer(win, "Bitwarden", 20, 54, float_center, true, "class")                                       -- Native app
    fn.resizer(win, "^Extension: %(Bitwarden Password Manager%) %- Bitwarden", 20, 54, float_center, false) -- Firefox
    fn.resizer(win, "nngceckbapebfimnlniiiahkandclblb", 20, 54, float_center, true, "class")                -- Chromium

    -- Picture in picture
    fn.resizer(win, "Picture[- ]in[- ][Pp]icture", 0, 0, pip_actions, false)
end

hl.on("window.title", apply_resizer_rules)
hl.on("window.open", apply_resizer_rules)
