local awful = require("awful")


local _M = {}
local iconsd = RC.vars.confdir .. "/icons/tags2420/"

function _M.get () 
    local tags = {} 

    awful.screen.connect_for_each_screen(function(s)
        local taglist = {}
        table.insert(taglist, awful.tag.add("main", {
            icon = RC.icons.tag_main,
            layout = RC.layouts[1],
            screen = s,
            selected = true,
        }))
        table.insert(taglist, awful.tag.add("www", {
            icon = RC.icons.tag_www, 
            layout = RC.layouts[1],
            screen = s,
        }))
        table.insert(taglist, awful.tag.add("media", {
            icon = RC.icons.tag_media, 
            layout = RC.layouts[1],
            screen = s,
        }))
        table.insert(taglist, awful.tag.add("mail", {
            icon = RC.icons.tag_mail, 
            layout = RC.layouts[1],
            screen = s,
        }))
        table.insert(taglist, awful.tag.add("im", {
            icon = RC.icons.tag_im, 
            layout = RC.layouts[1],
            screen = s,
        }))
        table.insert(taglist, awful.tag.add("etc", {
            icon = RC.icons.tag_etc,
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

