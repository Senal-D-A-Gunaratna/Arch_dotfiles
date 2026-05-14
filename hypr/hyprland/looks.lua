local colors = require("hyprland.colors")

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 5,
        border_size = 1,
        col = {
            active_border = colors.active_border
        },
        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle"
    },
    decoration = {
        rounding = 10,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)"
        },
        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696
        }
    },
    dwindle = {
        preserve_split = true
    },
    master = {
        new_status = "master"
    },
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo = true
    }
})

-- Curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Animations
hl.animation({ leaf = "border",        enabled = true, speed = 4.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 3.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 3,   bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.2, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.3, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.1, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 2,   bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3,   bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 3,   bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.2, bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.4, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.1, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 3,   bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 3,   bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3,   bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 5.5, bezier = "quick" })
