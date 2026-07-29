local terminal    = "ghostty"

hl.on("hyprland.start", function ()
  hl.exec_cmd(terminal, {
      workspace = "3"
  })
  hl.exec_cmd("nm-applet --indicator & blueman-applet")
  hl.exec_cmd("wl-paste --type text --watch cliphist store")
  hl.exec_cmd("wl-paste --type image --watch cliphist store")
  hl.exec_cmd("waybar & hyprpaper & google-chrome-stable & Telegram")
  hl.exec_cmd("swayosd-server & swaync")
  hl.exec_cmd("hyprpaper")
end)
