local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")

local _M = {}

local deco = {
    wallpaper   = require("deco.wallpaper"),
    taglist     = require("deco.taglist"),
    tasklist    = require("deco.tasklist")
}

local taglist_buttons   = deco.taglist()
local tasklist_buttons  = deco.tasklist() 

mytextclock = wibox.widget.textclock()
mykeyboardlayout = awful.widget.keyboardlayout()

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    
    s.mypromptbox = awful.widget.prompt({
        prompt = ">>>"
    })
    
    -- Create an imagebox widget
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))


    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        widget_template = {
            {
                {
                    id      = "icon_role",
                    widget  = wibox.widget.imagebox
                },
                left    = 4,
                right   = 4,
                widget  = wibox.container.margin
            },
            id      = "background_role",
            widget  = wibox.container.background
        }
    }
    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }
    -- Create the wibox
    s.mywibox = awful.wibar({ 
        position = "top",
        screen = s,
        height = 24
    })
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            RC.launcher,
            s.mytaglist,
            s.mypromptbox
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
        },
    }
end)
    
