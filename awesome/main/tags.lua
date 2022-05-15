local awful = require("awful")


local _M = {}
local iconsd = RC.vars.confdir .. "/icons/tags2420/"

function _M.get () 
    local tags = {} 

    awful.screen.connect_for_each_screen(function(s)
        local taglist = {}
        table.insert(taglist, awful.tag.add("main", {
            icon = iconsd .. "terminal.png",
            layout = RC.layouts[1],
            screen = s,
            selected = true,
        }))
        table.insert(taglist, awful.tag.add("www", {
            icon = iconsd .. "browser.png",
            layout = RC.layouts[1],
            screen = s,
        }))
        table.insert(taglist, awful.tag.add("media", {
            icon = iconsd .. "media.png",
            layout = RC.layouts[1],
            screen = s,
        }))
        table.insert(taglist, awful.tag.add("mail", {
            icon = iconsd .. "mail.png",
            layout = RC.layouts[1],
            screen = s,
        }))
        table.insert(taglist, awful.tag.add("im", {
            icon = iconsd .. "message.png",
            layout = RC.layouts[1],
            screen = s,
        }))
        table.insert(taglist, awful.tag.add("etc", {
            icon = iconsd .. "ellipsis.png",
            layout = RC.layouts[1],
            screen = s,
        }))

        tags[s] = taglist
    end)

    return tags

end

function _M.getx ()
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

