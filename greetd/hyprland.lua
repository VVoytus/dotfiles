hl.on("hyprland.start", function()
	hl.exec_cmd("regreet; hyprctl dispatch exit")
end)

hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		disable_hyprland_qtutils_check = true,
	},
})
