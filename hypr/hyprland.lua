-- Monitors
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = "auto",
})

-- Font
-- hl.config({
--     font = "JetBrainsMono Nerd Font"
-- })

-- Modules
require("hyprland.environment")
require("hyprland.input")
require("hyprland.keybinds")
require("hyprland.looks")
require("hyprland.rules")

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprlock")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("clipse -listen")
end)
