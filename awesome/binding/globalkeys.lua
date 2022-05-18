local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

local volume = require("components.volume")
local media = require("components.media")

local modkey = RC.vars.modkey
local terminal = RC.vars.terminal

local _M = {}

function _M.get()
    local globalkeys = gears.table.join(
        -- Tag browsing
        awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
                  {description="show help", group="awesome"}),
        awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
                  {description = "view previous", group = "tag"}),
        awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
                  {description = "view next", group = "tag"}),
        awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
                  {description = "go back", group = "tag"}),

        awful.key({ modkey,           }, "j",
            function ()
                awful.client.focus.byidx( 1)
            end,
            {description = "focus next by index", group = "client"}
        ),
        awful.key({ modkey,           }, "k",
            function ()
                awful.client.focus.byidx(-1)
            end,
            {description = "focus previous by index", group = "client"}
        ),
        awful.key({ modkey,           }, "w", function () RC.mainmenu:show() end,
            {description = "show main menu", group = "awesome"}),

        -- Layout manipulation
        awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
            {description = "swap with next client by index", group = "client"}),
        awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
            {description = "swap with previous client by index", group = "client"}),
        awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
            {description = "focus the next screen", group = "screen"}),
        awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
            {description = "focus the previous screen", group = "screen"}),
        awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
            {description = "jump to urgent client", group = "client"}),
        awful.key({ modkey,           }, "Tab",
            function ()
                awful.client.focus.history.previous()
                if client.focus then
                    client.focus:raise()
                end
            end,
            {description = "go back", group = "client"}),


        -- Standard program
        awful.key({ modkey,           }, "Return", function () awful.spawn(RC.vars.terminal) end,
            {description = "open a terminal", group = "launcher"}),
        awful.key({ modkey, "Control" }, "r", awesome.restart,
            {description = "reload awesome", group = "awesome"}),
        awful.key({ modkey, "Shift"   }, "q", awesome.quit,
            {description = "quit awesome", group = "awesome"}),

        -- Clients 
        awful.key({ modkey }, "l", function () awful.tag.incmwfact( 0.05) end,
            {description = "increase master width factor", group = "layout"}),
        awful.key({ modkey }, "h", function () awful.tag.incmwfact(-0.05) end,
            {description = "decrease master width factor", group = "layout"}),
        awful.key({ modkey, "Shift" }, "h", function () awful.tag.incnmaster( 1, nil, true) end,
            {description = "increase the number of master clients", group = "layout"}),
        awful.key({ modkey, "Shift" }, "l", function () awful.tag.incnmaster(-1, nil, true) end,
            {description = "decrease the number of master clients", group = "layout"}),
        awful.key({ modkey, "Control" }, "h", function () awful.tag.incncol( 1, nil, true) end,
            {description = "increase the number of columns", group = "layout"}),
        awful.key({ modkey, "Control" }, "l", function () awful.tag.incncol(-1, nil, true) end,
            {description = "decrease the number of columns", group = "layout"}),
        awful.key({ modkey }, "space", function () awful.layout.inc(1) end,
            {description = "select next", group = "layout"}),
        awful.key({ modkey, "Shift" }, "space", function () awful.layout.inc(-1) end,
            {description = "select previous", group = "layout"}),
        awful.key({ modkey, "Control" }, "n",
            function ()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                end
            end,
            {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey }, "r",
        function () awful.spawn("dmenu_run") end,
        { description = "run prompt (dmenu)", group = "launcher" }),

    -- Browser
    awful.key({ modkey }, "b",
        function () awful.spawn("google-chrome") end,
        { description = "Run browser", group = "applications" }),

    awful.key({ modkey }, "x",
        function ()
            awful.prompt.run {
                prompt       = "Run Lua code: ",
                textbox      = awful.screen.focused().mypromptbox.widget,
                exe_callback = awful.util.eval,
                history_path = awful.util.get_cache_dir() .. "/history_eval"
            }
        end,
        {description = "lua execute prompt", group = "awesome"}),

    -- Menubar
    awful.key({ modkey }, "p",
        function()
            awful.spawn("rofi -modi drun -show drun -show-icons -width 22 -no-click-to-exit")
        end,
        {description = "show the menubar (rofi)", group = "launcher"}),
   
    -- Screen lock
    awful.key({ modkey, "Mod1" }, "l",
        function()
            awful.spawn(RC.scripts.locker)
        end,
        {description = "lock screen", group = "awesome" }),
    
    -- Volume control
    volume.keybindings,

    -- Media control
    media.keybindings,

    awful.key({ }, "XF86MonBrightnessUp",
        function () awful.spawn("brightnessctl set +10%") end),
    awful.key({ }, "XF86MonBrightnessDown",
        function () awful.spawn("brightnessctl set 10%-") end),

    awful.key({ modkey }, "e", function()
        awful.spawn(RC.vars.terminal .." -e neomutt")
    end),

    awful.key({ "Mod1", "Control", "Shift" }, "a", function()
        awful.spawn("autorandr --change")
    end)

    )
    return globalkeys
end

return setmetatable({}, {
    __call = function(_, ...) return _M.get() end
})

