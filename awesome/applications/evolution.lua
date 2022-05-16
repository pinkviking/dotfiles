
local _M = {}

function _M.signal_connect(c)
    local function set_mail_icon(c)
        if string.find(c.name, "unread") ~= nil then
            c.first_tag.icon = RC.icons.launcher
        else
            c.first_tag.icon = RC.icons.tag_mail
        end
    end
    set_mail_icon(c)
    c:connect_signal("property::name", set_mail_icon)
end


return _M
