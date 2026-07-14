local theme = {}
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")

theme.dir = os.getenv("HOME") .. "/.config/awesome/theme"

-- AcreetionOS color palette
theme.ac_green      = "#2ecc71"
theme.ac_body_bg    = "#121212"
theme.ac_panel_bg   = "#1a1a1a"
theme.ac_box_bg     = "#222222"
theme.ac_box_border = "#333333"
theme.ac_text       = "#e5e5e5"
theme.ac_text_dim   = "#b2b2b2"
theme.ac_storm      = "#61afef"
theme.ac_flasher    = "#f39c12"
theme.ac_purple     = "#9b59b6"
theme.ac_code_bg    = "rgba(46,204,113,0.1)"

theme.font          = "Roboto 10"
theme.font_mono     = "Fira Code 10"
theme.taglist_font  = "Fira Code 12"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#2ecc71"
theme.bg_urgent     = "#f39c12"
theme.bg_minimize   = "#333333"
theme.bg_systray    = "#1a1a1a"

theme.fg_normal     = "#e5e5e5"
theme.fg_focus      = "#000000"
theme.fg_urgent     = "#000000"
theme.fg_minimize   = "#b2b2b2"

theme.border_width  = 2
theme.border_normal = "#333333"
theme.border_focus  = "#2ecc71"
theme.border_marked = "#f39c12"

theme.tasklist_bg_focus        = "#2ecc71"
theme.tasklist_fg_focus        = "#000000"
theme.tasklist_bg_normal        = "#1a1a1a"
theme.tasklist_fg_normal        = "#b2b2b2"
theme.tasklist_bg_urgent       = "#f39c12"
theme.tasklist_fg_urgent        = "#000000"

theme.taglist_fg_focus         = "#000000"
theme.taglist_bg_focus          = "#2ecc71"
theme.taglist_fg_occupied       = "#e5e5e5"
theme.taglist_bg_occupied       = "#222222"
theme.taglist_fg_urgent         = "#000000"
theme.taglist_bg_urgent         = "#f39c12"
theme.taglist_fg_empty          = "#555555"
theme.taglist_bg_empty          = "#1a1a1a"
theme.taglist_spacing           = 2

theme.menu_height               = 24
theme.menu_width                = 200
theme.menu_bg_normal            = "#1a1a1a"
theme.menu_bg_focus             = "#2ecc71"
theme.menu_fg_normal            = "#b2b2b2"
theme.menu_fg_focus             = "#000000"
theme.menu_border_color         = "#333333"
theme.menu_submenu_icon         = theme.dir .. "/icons/submenu.png"

theme.wallpaper                 = "/usr/share/backgrounds/acreetionos-awesome-wallpaper.png"

theme.border_width              = 2
theme.border_normal             = "#333333"
theme.border_focus              = "#2ecc71"
theme.border_marked             = "#f39c12"

theme.useless_gap               = 4
theme.gap_single_client          = true

theme.systray_icon_spacing       = 4
theme.bg_systray                 = "#1a1a1a"

theme.notification_bg            = "#222222"
theme.notification_fg            = "#e5e5e5"
theme.notification_border        = "#333333"
theme.notification_border_width  = 1
theme.notification_shape         = "rounded_rect"
theme.notification_opacity       = 0.95
theme.notification_margin        = 8
theme.notification_max_width     = 400
theme.notification_spacing       = 4

theme.tooltip_bg                 = "#222222"
theme.tooltip_fg                 = "#e5e5e5"
theme.tooltip_border             = "#333333"
theme.tooltip_border_width       = 1

theme.hotkeys_bg                 = "#121212"
theme.hotkeys_fg                 = "#e5e5e5"
theme.hotkeys_border             = "#333333"
theme.hotkeys_modifiers_fg       = "#2ecc71"
theme.hotkeys_label_bg           = "#1a1a1a"
theme.hotkeys_label_fg           = "#b2b2b2"
theme.hotkeys_group_margin       = 20

theme.wallpaper                  = "/usr/share/backgrounds/acreetionos-awesome-wallpaper.png"

theme.icon_theme                 = "Papirus-Dark"

return theme
