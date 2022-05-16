local scriptd = RC.vars.confdir .. "/scripts/"

local _M = {
    init        = scriptd .. "setupsession.sh",
    locker      = scriptd .. "screenlock.sh",
    mailwatch   = scriptd .. "mailwatch.py"
    
}

return _M
