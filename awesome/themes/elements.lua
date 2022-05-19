local colors = require("themes.colors")

local theme_assets  = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

theme.font          = "Roboto 9" 
theme.taglist_font  = "Roboto 9"
theme.useless_gap   = dpi(5)

theme.border_width  = dpi(1)
theme.border_normal = colors.background
theme.border_focus  = colors.purple
theme.border_marked = colors.yellow

theme.bg_normal     = colors.background
theme.bg_focus      = colors.purple
theme.bg_urgent     = colors.yellow
theme.bg_minimize   = colors.background_focused
theme.bg_systray    = colors.background

theme.fg_normal     = colors.foreground 
theme.fg_focus      = colors.foreground 
theme.fg_urgent     = colors.foreground 
theme.fg_minimize   = colors.foreground 

theme.taglist_bg_focus = colors.purple
theme.taglist_fg_focus = colors.foreground


local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.tasklist_bg_normal = colors.background
theme.tasklist_bg_focus  = colors.purple
theme.tasklist_fg_focus  = colors.foreground

theme.titlebar_bg_normal = colors.backgorund
theme.titlebar_bg_focus  = colors.purple
theme.titlebar_fg_focus  = colors.foreground

theme.menu_submenu_icon = theme.awesome_icon
theme.menu_height = 20      -- dpi(15)
theme.menu_width  = 180     -- dpi(100)
theme.menu_context_height = 20

theme.menu_bg_normal = colors.background  .. "cc"
theme.menu_bg_focus  = colors.pink .. "cc"
theme.menu_fg_focus  = colors.foreground

theme.menu_border_color = colors.pink
theme.menu_border_width = 1

