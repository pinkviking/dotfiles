local gears = require("gears")
local awful = require("awful")


local keybindings = gears.table.join(
    awful.key({ }, "XF86AudioMute",
        function () awful.spawn("amixer set Master toggle") end),
    awful.key({ }, "XF86AudioRaiseVolume",
        function () awful.util.spawn("amixer set Master 2%+ unmute") end),
    awful.key({ }, "XF86AudioLowerVolume",
        function () awful.spawn("amixer set Master 2%-") end)
)


return {
    keybindings = keybindings
}

