local gears = require("gears")
local awful = require("awful")

local _M = {}

function _M.get()
    local globalbuttons = gears.table.join(
        awful.button({ }, 3, function () RC.mainmenu:toggle() end),
        awful.button({ RC.vars.modkey }, 5, awful.tag.viewnext),
        awful.button({ RC.vars.modkey }, 4, awful.tag.viewprev)

    )

    return globalbuttons
end


return setmetatable({}, {
    __call = function(_,...) return _M.get(...) end
})


