local gears = require("gears")
local awful = require("awful")

RC.autorun.add("playerctld daemon")

local keybindings = gears.table.join(
    -- play/pause
    awful.key({ "Control", "Mod1" }, "p",
        function () awful.spawn("playerctl play-pause") end,
        { description = "Play/Pause", group = "media" }),

    awful.key({ }, "XF86AudioPlay",
        function () awful.spawn("playerctl play-pause") end),



    -- next
    awful.key({ "Control", "Mod1" }, "n",
        function () awful.spawn("playerctl next") end,
        { description = "next", group = "media" }),

    -- prev
    awful.key({ "Control", "Mod1" }, "b",
        function () awful.spawn("playerctl previous") end,
        { description = "previous", group = "media" })
)

awesome.connect_signal("exit", function ()
    awful.spawn("pkill playerctld") 
end)

return {
    keybindings = keybindings
}
