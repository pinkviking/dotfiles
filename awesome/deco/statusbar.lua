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

    -- Create an imagebox widget
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({ }, 1, function () awful.layout.inc( 1) end),
        awful.button({ }, 3, function () awful.layout.inc(-1) end),
        awful.button({ }, 4, function () awful.layout.inc( 1) end),
        awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Promptbox
    s.mypromptbox = awful.widget.prompt({ prompt = ">" })
   
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
    s.mytaglistcontainer = wibox.container.margin(
        s.mytaglist, 2, 10)
        
    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
		style    = {
				shape_border_width = 1,
				shape_border_color = '#777777',
				shape  = gears.shape.rounded_bar,
			},
		layout   = {
			spacing = 10,
			spacing_widget = {
				{
					forced_width = 5,
					shape        = gears.shape.circle,
					widget       = wibox.widget.separator
				},
				valign = 'center',
				halign = 'center',
				widget = wibox.container.place,
			},
			layout  = wibox.layout.flex.horizontal
		},
		-- Notice that there is *NO* wibox.wibox prefix, it is a template,
		-- not a widget instance.
		widget_template = {
			{
				{
					{
						{
							id     = 'icon_role',
							widget = wibox.widget.imagebox,
						},
						margins = 2,
						widget  = wibox.container.margin,
					},
					{
						id     = 'text_role',
						widget = wibox.widget.textbox,
					},
					layout = wibox.layout.fixed.horizontal,
				},
				left  = 10,
				right = 10,
				widget = wibox.container.margin
			},
			id     = 'background_role',
			widget = wibox.container.background,
		},
    }

    -- Launcher Margin
    s.mylauncher = wibox.container.margin(RC.launcher, 6, 6, 0 ,0) 

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
            s.mylauncher,
            s.mytaglistcontainer,
            s.mypromptbox,
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
    
