local gears = require("gears")
local awful = require("awful")
local naughty = require("naughty")

local _M = {}



local function set_mail_icon(icon)
    for s in screen do
        awful.tag.find_by_name(s, "mail").icon = icon
    end
end

local function check_unread()
    awful.spawn.easy_async(
        RC.scripts.mailwatch .. " check",
        function(stdout, stderr)
            if string.len(stderr) > 0 then
                naughty.notify({
                    text = "Mailwatch err: " .. stderr
                })
            else
                local numvalue = tonumber(stdout) 
                if numvalue > 0 then
                    set_mail_icon(RC.icons.tag_gotmail)
                else
                    set_mail_icon(RC.icons.tag_mail)
                end
            end
        end)
end

gears.timer{
    timeout = 60,
    call_now = true,
    autostart = true,
    callback  = check_unread
}

return _M
