local colors = require("themes/catppuccin-mocha")
local smw = hl.plugin.split_monitor_workspaces

------------------
---- MONITORS ----
------------------

-- See https://wiki.hyprland.org/Configuring/Basics/Monitors/

hl.monitor({ output = "eDP-1", mode = "highres", position = "auto", scale = 1 })
hl.monitor({ output = "HDMI-A-1", mode = "highres", position = "auto", scale = 1 })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1, mirror = "eDP-1" })

-- smw.monitor_priority({ "HDMI-A-1", "eDP-1" })

---------------------
---- MY PROGRAMS ----
---------------------

local function uwsm_launch_app(name)
	return "uwsm app -- " .. name
end

local function uwsm_launch_service(name)
	return "uwsm app -t service -- " .. name
end

-- Set programs that you use
local terminal = "ghostty"
local file_manager = "thunar"
local menu_app = "hyprlauncher"
local menu_service = menu_app .. " -d"
local browser = "apulse zen-browser"
local code_editor = "cursor"
local music_player = "/usr/share/applications/com.yktoo.ymuse.desktop"
local mail_client = "thunderbird"

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- Autostart necessary processes (like notifications daemons, status bars, etc.)

hl.on("hyprland.start", function()
	hl.exec_cmd(uwsm_launch_service(menu_service))
	hl.exec_cmd(uwsm_launch_app(browser), { workspace = "2 silent" })
	hl.exec_cmd(uwsm_launch_app(terminal), { workspace = "3 silent" })
	hl.exec_cmd(uwsm_launch_app(code_editor))
	hl.exec_cmd(uwsm_launch_app(music_player), { workspace = "5 silent" })
	hl.exec_cmd(uwsm_launch_app(mail_client), { workspace = "6 silent" })
	hl.dsp.focus({ workspace = 1 })
	hl.exec_cmd("hyprpm reload -f -n")
end)

hl.on("config.reloaded", function()
	hl.exec_cmd("hyprshade auto")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface gtk-theme 'catppuccin-mocha-rosewater-standard+default'")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface color-scheme 'prefer-Dark'")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "16")
hl.env("HYPRCURSOR_SIZE", "16")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("GTK_THEME", "catppuccin-mocha-rosewater-standard+default")
hl.env("TERMINAL", "/usr/bin/ghostty")

-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-----------------------
---- LOOK AND FEEL ----
-----------------------

-- See https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 8,

		border_size = 1,

		col = {
			active_border = colors.surface2,
			inactive_border = colors.surface0,
		},

		resize_on_border = true,
		allow_tearing = false,

		layout = "dwindle",

		snap = {
			enabled = true,
		},
	},

	decoration = {
		rounding = 8,
		rounding_power = 2,

		active_opacity = 1.0,
		inactive_opacity = 0.8,

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
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Default springs
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-----------------
---- LAYOUTS ----
-----------------

hl.config({
	-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
	dwindle = {
		preserve_split = true,
	},

	-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
	master = {
		new_status = "slave",
	},

	-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

---------------
---- INPUT ----
---------------

-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input for more

hl.config({
	input = {
		kb_layout = "pl",
	},
})

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/ for more

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

----------------
----  MISC  ----
----------------

-- See https://wiki.hypr.land/Configuring/Basics/Variables/#misc for more

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

-----------------
---- PLUGINS ----
-----------------

hl.config({
	plugin = {
		split_monitor_workspaces = {
			count = 6,
			keep_focused = 1,
			enable_notifications = 0,
			enable_persistent_workspaces = 0,
			enable_wrapping = 1,
			link_monitors = 0,
		},
	},
})

---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local function main_mod(key)
	return "SUPER + " .. key
end

hl.bind(main_mod("RETURN"), hl.dsp.exec_cmd(uwsm_launch_app(terminal)))
hl.bind(main_mod("E"), hl.dsp.exec_cmd(uwsm_launch_app(file_manager)))
hl.bind(main_mod("S"), hl.dsp.exec_cmd(uwsm_launch_app(menu_app)))

hl.bind(main_mod("Q"), hl.dsp.window.close())
hl.bind(main_mod("W"), hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(
	main_mod("SHIFT + Q"),
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)

hl.bind(main_mod("V"), hl.dsp.window.float({ action = "toggle" }))
hl.bind(main_mod("P"), hl.dsp.window.pseudo())
hl.bind(main_mod("J"), hl.dsp.layout("togglesplit")) -- dwindle only

-- Move focus with main_mod arrow keys
hl.bind(main_mod("left"), hl.dsp.focus({ direction = "left" }))
hl.bind(main_mod("right"), hl.dsp.focus({ direction = "right" }))
hl.bind(main_mod("up"), hl.dsp.focus({ direction = "up" }))
hl.bind(main_mod("down"), hl.dsp.focus({ direction = "down" }))

-- Scroll through workspaces with main_mod + SHIFT + left/right
hl.bind(main_mod("SHIFT + left"), function()
	smw.workspace("-1")
end)
hl.bind(main_mod("SHIFT + right"), function()
	smw.workspace("+1")
end)

-- Switch workspaces with main_mod [0-9]
-- Move active window to a workspace with main_mod SHIFT [0-9]
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(main_mod(key), function()
		return smw.workspace(i)
	end)
	hl.bind(main_mod("SHIFT + " .. key), function()
		return smw.move_to_workspace_silent(i)
	end)
end

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(main_mod("mouse:272"), hl.dsp.window.drag(), { mouse = true })
hl.bind(main_mod("mouse:273"), hl.dsp.window.resize(), { mouse = true })

-- Example special workspace (scratchpad)
hl.bind(main_mod("M"), hl.dsp.workspace.toggle_special("magic"))
hl.bind(main_mod("SHIFT + M"), hl.dsp.window.move({ workspace = "special:magic" }))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Requires hyprshot
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-- Requires wleave
hl.bind("XF86PowerOff", hl.dsp.exec_cmd("wleave"), { locked = true })

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
	name = "default",
	match = {
		class = ".*",
	},

	float = true, -- opens all windows floating by default
	idle_inhibit = "fullscreen", -- inhibit hypridle on fullscreen windows (e.g. video players)
	suppress_event = "maximize", -- ignore maximize requests from apps
})

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

hl.window_rule({
	name = "picture-in-picture",
	match = {
		title = "^(picture-in-Picture)$",
	},

	float = true,
	pin = true,
	move = { "69.5%", "4%" },
})

hl.window_rule({
	name = "cursor-in-4th-workspace",
	match = {
		class = "^cursor$",
	},

	workspace = "4 silent",
})

hl.window_rule({
	name = "tiled",
	match = {
		class = "^org.pwmt.zathura|calibre-gui|zen|com.mitchellh.ghostty|cursor|ymuse|org.mozilla.Thunderbird$",
	},

	tile = true,
})

hl.workspace_rule({
	workspace = "1",
	persistent = true,
	default = true,
})
for i = 2, 6 do
	hl.workspace_rule({
		workspace = tostring(i),
		persistent = true,
	})
end
