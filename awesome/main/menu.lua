local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget

local beautiful = require("beautiful")

local M = {} -- Menu
local _M = {} -- Module

M.awesome = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", RC.vars.terminal .. " -e man awesome" },
   { "edit config", RC.vars.editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

function _M.get()
    local menu_items = {
        { "awesome", M.awesome, beautiful.awesome_subicon },
        { "open terminal", RC.terminal }
    }

    return menu_items
end

return setmetatable(
    {},
    { __call = function(_, ...) return _M.get(...) end }
)

