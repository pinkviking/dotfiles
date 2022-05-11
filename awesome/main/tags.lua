local awful = require("awful")

local _M = {}

function _M.get ()
    tags = {}

    awful.screen.connect_for_each_screen(function(s)

    -- Each screen has its own tag table.
        local t_names = { "main", "www", "media", "mail", "im" }
        tags[s] = awful.tag(t_names, s, RC.layouts[1])

    end)

    return tags
end

return setmetatable(
    {},
    { __call = function(_, ...) return _M.get(...) end }
)

