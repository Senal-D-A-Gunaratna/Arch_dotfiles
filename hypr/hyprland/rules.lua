--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Ignore maximize requests from all apps
hl.window_rule({
    name          = "suppress-maximize-events",
    match         = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus = true,
})

-- hyprland-run float rule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- waypaper menu
hl.window_rule({
    name   = "waypaper-float",
    match  = { class = "waypaper" },
    float  = true,
    center = true,
    size   = { 800, 780 },
})

-- Opacity rules
hl.window_rule({
    match   = { class = "codium" },
    opacity = "0.8 0.85",
})

hl.window_rule({
    match   = { class = "localsend" },
    opacity = "0.75 0.8",
})

hl.window_rule({
    match   = { class = "kitty", title = "nvim" },
    opacity = "0.7 0.8",
})
