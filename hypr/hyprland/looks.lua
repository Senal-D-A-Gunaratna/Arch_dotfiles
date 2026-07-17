-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 5,

		border_size = 1,

		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 1.0,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},

	dwindle = {
		preserve_split = true,
	},

	master = {
		new_status = "master",
	},

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
})

-----------------
---- CURVES -----
-----------------

--            NAME,           X0,    Y0,    X1,    Y1
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

--------------------
---- ANIMATIONS ----
--------------------

--                  NAME,             ON,    SPEED,  CURVE,           [STYLE]
hl.animation({ leaf = "border", enabled = true, speed = 4.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 3.5, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.2, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.3, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.1, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.2, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.4, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.1, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 5.5, bezier = "quick" })

-- Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
-- "Smart gaps" / "No gaps when only" — uncomment if desired:
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
