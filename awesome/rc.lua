-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
--
local menubar = require("menubar")

-- Global namespace
RC = {}
RC.vars = require("main.user-variables")
RC.icons = require("main.icons")
RC.autorun = require("main.autorun")
modkey = RC.vars.modkey

-- Init config
beautiful.init(RC.vars.confdir .. "/themes/theme.lua")
-- beautiful.useless_gap = 5
print(beautiful.wallpaper)

-- Error handling
require("main.error-handling")

-- Custom Local Library
local main = {
    layouts = require("main.layouts"),
    tags = require("main.tags"),
    menu = require("main.menu"),
    rules = require("main.rules")
}

local binding = {
    globalbuttons = require("binding.globalbuttons"),
    clientbuttons = require("binding.clientbuttons"),
    globalkeys = require("binding.globalkeys"),
    clientkeys = require("binding.clientkeys"),
    bindtotags = require("binding.bindtotags")
}

-- Layouts
RC.layouts = main.layouts

-- Tags
RC.tags = main.tags()

-- Menu
RC.mainmenu = awful.menu({ items = main.menu() })
RC.launcher = awful.widget.launcher(
    { image = beautiful.awesome_icon, menu = RC.mainmenu }
)
menubar.utils.terminal = RC.vars.terminal -- Set the terminal for applications that require it

-- Rules 
awful.rules.rules = main.rules(binding.clientkeys(), binding.clientbuttons())

-- Keys
RC.globalkeys = binding.globalkeys()
RC.globalkeys = binding.bindtotags(RC.globalkeys)

-- Mouse and Keybindings
root.buttons(binding.globalbuttons())
root.keys(RC.globalkeys)

-- Signals
require("main.signals")

-- Statusbar
require("deco.statusbar")

-- Autorun programs
RC.autorun.add(RC.vars.confdir .. "/scripts/setupsession.sh")
RC.autorun.add("picom")

RC.autorun.run()


