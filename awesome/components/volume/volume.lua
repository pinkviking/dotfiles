-------------------------------------------------
-- The Ultimate Volume Widget for Awesome Window Manager
-- More details could be found here:
-- https://github.com/streetturtle/awesome-wm-widgets/tree/master/volume-widget

-- @author Pavel Makhov
-- @copyright 2020 Pavel Makhov
-------------------------------------------------

local awful = require("awful")
local wibox = require("wibox")
local spawn = require("awful.spawn")
local gears = require("gears")
local beautiful = require("beautiful")
local watch = require("awful.widget.watch")

local volume_widget = require("components.volume.volume-widget")

local function GET_VOLUME_CMD() return 'amixer sget Master' end
local function INC_VOLUME_CMD(step) return 'amixer sset Master ' .. step .. '%+' end
local function DEC_VOLUME_CMD(step) return 'amixer sset Master ' .. step .. '%-' end
local function TOG_VOLUME_CMD() return 'amixer sset Master toggle' end


local volume = {}

local function worker(user_args)

    local args = user_args or {}

    local mixer_cmd = args.mixer_cmd or 'pavucontrol'
    local refresh_rate = args.refresh_rate or 1
    local step = args.step or 5

    volume.widget = volume_widget.get_widget(args)

    local function update_graphic(widget, stdout)
        local mute = string.match(stdout, "%[(o%D%D?)%]")   -- \[(o\D\D?)\] - [on] or [off]
        if mute == 'off' then widget:mute()
        elseif mute == 'on' then widget:unmute()
        end
        local volume_level = string.match(stdout, "(%d?%d?%d)%%") -- (\d?\d?\d)\%)
        volume_level = string.format("% 3d", volume_level)
        widget:set_volume_level(volume_level)
    end

    function volume:inc(s)
        spawn.easy_async(
			INC_VOLUME_CMD(s or step),
			function(stdout) update_graphic(volume.widget, stdout) end
		)
    end

    function volume:dec(s)
        spawn.easy_async(
			DEC_VOLUME_CMD(s or step),
			function(stdout) update_graphic(volume.widget, stdout) end
		)
    end

    function volume:toggle()
        spawn.easy_async(
			TOG_VOLUME_CMD(),
			function(stdout) update_graphic(volume.widget, stdout) end
		)
    end

    function volume:mixer()
        if mixer_cmd then
            spawn.easy_async(mixer_cmd)
        end
    end

    volume.widget:buttons(
            awful.util.table.join(
                    awful.button({}, 4, function() volume:inc() end),
                    awful.button({}, 5, function() volume:dec() end),
                    awful.button({}, 2, function() volume:mixer() end),
                    awful.button({}, 1, function() volume:toggle() end)
            )
    )

    watch(GET_VOLUME_CMD(device), refresh_rate, update_graphic, volume.widget)
    
    volume.widget.keybindings = gears.table.join(
        awful.key({ }, "XF86AudioMute",
            function () volume:toggle()  end),
        awful.key({ }, "XF86AudioRaiseVolume",
            function () volume:inc() end),
        awful.key({ }, "XF86AudioLowerVolume",
            function () volume:dec() end)
    )

    return volume.widget
end

return setmetatable(volume, { __call = function(_, ...) return worker(...) end })

