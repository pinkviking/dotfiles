local awful = require("awful")
awful.util = require("awful.util")

local homedir = os.getenv("HOME")
local confdir = homedir .. "/.config/awesome"
theme_path = confdir .. "/themes/"

theme = {}

dofile(theme_path .. "elements.lua")
-- dofile(theme_path .. "titlebar.lua")
-- dofile(theme_path .. "layouts.lua")

theme.wallpaper         = homedir .. "/.themes/wallpaper/wallp.png"
theme.awesome_icon      = RC.icons.launcher
theme.awesome_subicon   = RC.icons.launcher

return theme


