local home = os.getenv("HOME")
local terminal = "alacritty"
local editor = "/usr/bin/vim" or "vi"

_M = {
    home = home,
    confdir = home .. "/.config/awesome",
    terminal = terminal,
    editor = editor,
    editor_cmd = terminal .. " -e " .. editor,
    modkey = "Mod4"
}

return _M

