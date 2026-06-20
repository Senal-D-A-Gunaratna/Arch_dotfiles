-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

local cursor = "Bibata-Modern-Ice"

hl.env("XCURSOR_SIZE",    "24")
hl.env("XCURSOR_THEME",   cursor)
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_THEME", cursor)

hl.config({
    cursor = {
        inactive_timeout = 3, -- hide cursor after 3 seconds of inactivity
    },
})

-- QT Theming
hl.env("QT_QPA_PLATFORMTHEME", "hyprqt6engine")

-- Font
hl.config({
    misc = {
        font_family = "JetBrainsMono Nerd Font",
    },
})
