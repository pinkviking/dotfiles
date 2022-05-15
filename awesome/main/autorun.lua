local awful = require("awful")

local autorun = true
local autorunCommands = {}
local _M = {}

function _M.add(command)
    table.insert(autorunCommands, command)
end

function _M.run() 
    if autorun then 
        for cmd = 1, #autorunCommands do
            awful.spawn(autorunCommands[cmd])
        end
    end
end

function _M.setAutorun(shouldAutorun)
    autorun = shouldAutorun
end


return _M
