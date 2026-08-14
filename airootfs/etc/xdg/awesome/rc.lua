local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

terminal = "acreetionos-terminal"
if not io.popen("which acreetionos-terminal 2>/dev/null"):read() then
    terminal = "kitty"
end
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
browser = "firefox"
modkey = "Mod4"

local awesome, client, mouse, screen, tag = awesome, client, mouse, screen, tag
local ipairs, string, os, table, tostring, tonumber, type = ipairs, string, os, table, tostring, tonumber, type

local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local wibox = require("wibox")
local dpi = require("beautiful.xresources").apply_dpi

require("awful.autofocus")
require("awful.hotkeys_popup.keys")

beautiful.init(gears.filesystem.get_configuration_dir() .. "theme/theme.lua")

terminal = "acreetionos-terminal"
if not io.popen("which acreetionos-terminal 2>/dev/null"):read() then
    terminal = "kitty"
end
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
browser = "firefox"
modkey = "Mod4"

local layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    awful.layout.suit.floating,
}

awful.util.tagnames = { "1:term", "2:web", "3:code", "4:media", "5:sys", "6:chat", "7:docs", "8:games", "9:misc" }

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating,
}

awful.util.taglist_buttons = gears.table.join(
    awful.button({}, 1, function(t) t:view_only() end),
    awful.button({ modkey }, 1, function(t)
        if client.focus then client.focus:move_to_tag(t) end
    end),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, function(t)
        if client.focus then client.focus:toggle_tag(t) end
    end),
    awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

awful.util.tasklist_buttons = gears.table.join(
    awful.button({}, 1, function(c)
        if c == client.focus then
            c.minimized = true
        else
            c:emit_signal("request::activate", "tasklist", { raise = true })
        end
    end),
    awful.button({}, 3, function()
        awful.menu.client_list({ theme = { width = 250 } })
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
    end)
)

local function set_wallpaper(s)
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        if type(wallpaper) == "string" then
            wallpaper = gears.filesystem.get_configuration_dir() .. "theme/wallpaper.png"
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    set_wallpaper(s)

    awful.tag({ "1:term", "2:web", "3:code", "4:media", "5:sys", "6:chat", "7:docs", "8:games", "9:misc" }, s, awful.layout.layouts[1])

    s.mypromptbox = awful.widget.prompt()

    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function() awful.layout.inc(1) end),
        awful.button({}, 3, function() awful.layout.inc(-1) end),
        awful.button({}, 4, function() awful.layout.inc(1) end),
        awful.button({}, 5, function() awful.layout.inc(-1) end)
    ))

    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({}, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                if client.focus then client.focus:move_to_tag(t) end
            end),
            awful.button({}, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                if client.focus then client.focus:toggle_tag(t) end
            end),
            awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
            awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end),
        }
    }

    s.mytasklist = awful.widget.tasklist {
        screen   = s,
        filter   = awful.widget.tasklist.filter.currenttags,
        buttons  = {
            awful.button({}, 1, function(c)
                if c == client.focus then
                    c.minimized = true
                else
                    c:emit_signal("request::activate", "tasklist", { raise = true })
                end
            end),
            awful.button({}, 3, function()
                awful.menu.client_list({ theme = { width = 250 } })
            end),
            awful.button({}, 4, function() awful.client.focus.byidx(1) end),
            awful.button({}, 5, function() awful.client.focus.byidx(-1) end)
        },
        layout = {
            spacing = 2,
            layout = wibox.layout.fixed.horizontal,
        },
        style = {
            shape_border_width = 0,
        },
    }

    s.mypromptbox = awful.widget.prompt()

    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = dpi(32),
        bg = "#1a1a1a",
        fg = "#e5e5e5",
        border_width = 0,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 0)
        end,
    })

    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            s.mylayoutbox,
        },
    }
end)

root.buttons(gears.table.join(
    awful.button({}, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
    awful.button({}, 4, function() awful.tag.viewnext() end),
    awful.button({}, 5, function() awful.tag.viewprev() end)
))

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

globalkeys = gears.table.join(
    awful.key({ modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
    awful.key({ modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
    awful.key({ modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
    awful.key({ modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),

    awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end,
        { description = "focus next by index", group = "client" }),
    awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end,
        { description = "focus previous by index", group = "client" }),
    awful.key({ modkey }, "w", function() awful.layout.inc(1) end,
        { description = "next layout", group = "layout" }),
    awful.key({ modkey, "Shift" }, "w", function() awful.layout.inc(-1) end,
        { description = "previous layout", group = "layout" }),

    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        if c then
            c:emit_signal("request::activate", "key.unminimize", { raise = true })
        end
    end, { description = "restore minimized", group = "client" }),

    awful.key({ modkey }, "Return", function() awful.spawn(terminal) end,
        { description = "open terminal", group = "launcher" }),
    awful.key({ modkey, "Shift" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),
    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),

    awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width", group = "layout" }),
    awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width", group = "layout" }),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
        { description = "increase master clients", group = "layout" }),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
        { description = "decrease master clients", group = "layout" }),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1, nil, true) end,
        { description = "increase columns", group = "layout" }),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1, nil, true) end,
        { description = "decrease columns", group = "layout" }),

    awful.key({ modkey }, "space", function() awful.layout.inc(1) end,
        { description = "next layout", group = "layout" }),
    awful.key({ modkey, "Shift" }, "space", function() awful.layout.inc(-1) end,
        { description = "previous layout", group = "layout" }),

    awful.key({ modkey, "Control" }, "r", awesome.restart,
        { description = "reload awesome", group = "awesome" }),

    awful.key({ modkey, "Shift" }, "q", awesome.quit,
        { description = "quit awesome", group = "awesome" }),

    awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end,
        { description = "increase master width", group = "layout" }),
    awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end,
        { description = "decrease master width", group = "layout" }),

    awful.key({ modkey, "Shift" }, "j", function() awful.client.focus.byidx(1) end,
        { description = "focus next by index", group = "client" }),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.focus.byidx(-1) end,
        { description = "focus previous by index", group = "client" }),

    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end,
        { description = "focus next screen", group = "screen" }),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
        { description = "focus previous screen", group = "screen" }),

    awful.key({ modkey }, "u", awful.client.urgent.jumpto,
        { description = "jump to urgent client", group = "client" }),

    awful.key({ modkey }, "Tab", function()
        awful.client.focus.history.previous()
        if client.focus then
            client.focus:emit_signal("request::activate", "key.unminimize", { raise = true })
        end
    end, { description = "go back", group = "client" }),

    awful.key({ modkey, "Control" }, "n", function()
        local c = awful.client.restore()
        if c then
            c:emit_signal("request::activate", "key.unminimize", { raise = true })
        end
    end, { description = "restore minimized", group = "client" }),

    awful.key({ modkey }, "r", function() awful.screen.focused().mypromptbox:run() end,
        { description = "run prompt", group = "launcher" }),

    awful.key({ modkey }, "x", function()
        awful.prompt.run {
            prompt = "Run Lua code: ",
            textbox = awful.screen.focused().mypromptbox.widget,
            exe_callback = function(cmd)
                local f, err = loadstring("return " .. cmd)
                if f then
                    local result = f()
                    naughty.notification {
                        title = "Lua Result",
                        text = tostring(result),
                        timeout = 5,
                    }
                else
                    naughty.notification {
                        title = "Lua Error",
                        text = tostring(err),
                        timeout = 5,
                    }
                end
            end,
        }
    end, { description = "lua execute prompt", group = "awesome" }),

    awful.key({ modkey }, "b", function()
        for s in screen do
            s.mywibox.visible = not s.mywibox.visible
        end
    end, { description = "toggle wibox", group = "awesome" }),

    awful.key({ modkey }, "d", function()
        awful.spawn("rofi -show drun")
    end, { description = "rofi app launcher", group = "launcher" }),

    awful.key({ modkey }, "p", function()
        awful.spawn("rofi -show run")
    end, { description = "rofi run", group = "launcher" }),

    awful.key({ modkey, "Shift" }, "d", function()
        awful.spawn("rofi -show window")
    end, { description = "rofi window switcher", group = "launcher" }),

    awful.key({ modkey }, "F2", function()
        awful.spawn.with_shell("flameshot gui")
    end, { description = "screenshot", group = "utility" }),

    awful.key({ modkey }, "F4", function()
        awful.spawn("firefox")
    end, { description = "open browser", group = "launcher" }),

    awful.key({ modkey }, "e", function()
        awful.spawn("thunar")
    end, { description = "file manager", group = "launcher" }),

    awful.key({ modkey }, "c", function()
        awful.spawn("code")
    end, { description = "code editor", group = "launcher" }),

    awful.key({ modkey }, "v", function()
        awful.spawn("pavucontrol")
    end, { description = "volume control", group = "launcher" }),

    awful.key({ modkey }, "s", function()
        awful.spawn("firefox")
    end, { description = "web browser", group = "launcher" }),

    awful.key({ modkey }, "a", function()
        awful.spawn("rofi -show drun")
    end, { description = "app launcher", group = "launcher" }),

    awful.key({ modkey, "Shift" }, "a", function()
        awful.spawn("rofi -show window")
    end, { description = "window switcher", group = "launcher" }),

    awful.key({ modkey, "Control" }, "l", function()
        awful.spawn("betterlockscreen -l")
    end, { description = "lock screen", group = "system" }),

    awful.key({ modkey, "Control" }, "s", function()
        awful.spawn("flameshot gui")
    end, { description = "screenshot", group = "utility" }),

    awful.key({ modkey }, "F12", function()
        awful.spawn("pavucontrol")
    end, { description = "audio settings", group = "system" }),

    awful.key({}, "XF86AudioRaiseVolume", function()
        awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%", false)
    end),
    awful.key({}, "XF86AudioLowerVolume", function()
        awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%", false)
    end),
    awful.key({}, "XF86AudioMute", function()
        awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle", false)
    end),
    awful.key({}, "XF86AudioPlay", function()
        awful.spawn("playerctl play-pause", false)
    end),
    awful.key({}, "XF86AudioNext", function()
        awful.spawn("playerctl next", false)
    end),
    awful.key({}, "XF86AudioPrev", function()
        awful.spawn("playerctl previous", false)
    end),
    awful.key({}, "XF86MonBrightnessUp", function()
        awful.spawn("brightnessctl s +5%", false)
    end),
    awful.key({}, "XF86MonBrightnessDown", function()
        awful.spawn("brightnessctl s 5%-", false)
    end),
)

clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "q", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }),
    awful.key({ modkey }, "o", function(c) c:move_to_screen() end,
        { description = "move to screen", group = "client" }),
    awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end,
        { description = "toggle keep on top", group = "client" }),
    awful.key({ modkey }, "n", function(c)
        c.minimized = true
    end, { description = "minimize", group = "client" }),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end, { description = "maximize", group = "client" }),
    awful.key({ modkey, "Control" }, "m", function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end, { description = "maximize vertically", group = "client" }),
    awful.key({ modkey, "Shift" }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end, { description = "maximize horizontally", group = "client" }),
)

clientkeys = gears.table.join(
    awful.key({ modkey }, "f", function(c)
        c.fullscreen = not c.fullscreen
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end, { description = "toggle fullscreen", group = "client" }),
    awful.key({ modkey }, "q", function(c) c:kill() end,
        { description = "close", group = "client" }),
    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle,
        { description = "toggle floating", group = "client" }),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end,
        { description = "move to master", group = "client" }),
    awful.key({ modkey }, "o", function(c) c:move_to_screen() end,
        { description = "move to screen", group = "client" }),
    awful.key({ modkey }, "t", function(c) c.ontop = not c.ontop end,
        { description = "toggle on top", group = "client" }),
    awful.key({ modkey }, "n", function(c) c.minimized = true end,
        { description = "minimize", group = "client" }),
    awful.key({ modkey }, "m", function(c)
        c.maximized = not c.maximized
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end, { description = "maximize", group = "client" }),
    awful.key({ modkey, "Control" }, "m", function(c)
        c.maximized_vertical = not c.maximized_vertical
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end, { description = "maximize vertically", group = "client" }),
    awful.key({ modkey, "Shift" }, "m", function(c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end, { description = "maximize horizontally", group = "client" })
)

clientbuttons = gears.table.join(
    awful.button({}, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
    end),
    awful.button({ modkey }, 1, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function(c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)

root.keys(globalkeys)

client.connect_signal("request::desktop_decoration", function(c)
    c.buttons = clientbuttons
    c:connect_signal("request::activate", function(c, context, hints)
        if not hints or not hints["switch_to_tag"] then
            awful.client.focus.filter(c, context, hints)
        end
    end)
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("request::geometry", function(c, context, hints)
    if context == "titlebar" then
        local titlebar = c.titlebar
        if titlebar then
            titlebar:setup {
                { -- Left
                    awful.titlebar.widget.iconwidget(c),
                    buttons = {
                        awful.button({}, 1, function()
                            c:emit_signal("request::activate", "titlebar", { raise = true })
                            awful.mouse.client.move(c)
                        end),
                    },
                    layout = wibox.layout.fixed.horizontal,
                },
                {
                    awful.titlebar.widget.titlewidget(c),
                    layout = wibox.layout.flex.horizontal,
                },
                {
                    awful.titlebar.widget.stickybutton(c),
                    awful.titlebar.widget.ontopbutton(c),
                    awful.titlebar.widget.maximizedbutton(c),
                    awful.titlebar.widget.closebutton(c),
                    layout = wibox.layout.fixed.horizontal,
                },
                layout = wibox.layout.align.horizontal,
            }
        end
    end)
end)

client.connect_signal("manage", function(c)
    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        awful.placement.no_offscreen(c)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

client.connect_signal("request::titlebars", function(c)
    c.titlebar = awful.titlebar(c, {
        position = "top",
        size = 28,
        bg = "#1a1a1a",
        fg = "#e5e5e5",
    })
end)

client.connect_signal("property::floating", function(c)
    if c.floating then
        c.border_width = beautiful.border_width
    else
        c.border_width = beautiful.border_width
    end
end)

client.connect_signal("property::maximized", function(c)
    if c.maximized then
        c.border_width = 0
    else
        c.border_width = beautiful.border_width
    end
end)

client.connect_signal("property::fullscreen", function(c)
    if c.fullscreen then
        c.border_width = 0
    else
        c.border_width = beautiful.border_width
    end
end)

awful.spawn.with_shell("picom --config ~/.config/picom/picom.conf &")
awful.spawn.with_shell("nm-applet &")
awful.spawn.with_shell("blueman-applet &")
awful.spawn.with_shell("dunst &")
awful.spawn.with_shell("feh --bg-scale /usr/share/backgrounds/acreetionos-awesome-wallpaper.png &")
awful.spawn.with_shell("xsetroot -cursor_name left_ptr &")
awful.spawn.with_shell("xrdb -merge ~/.Xresources 2>/dev/null &")

awful.spawn.with_shell("pkill picom; picom --config /etc/xdg/picom.conf &")

naughty.config.defaults.timeout = 5
naughty.config.defaults.position = "top_right"
naughty.config.defaults.margin = 8
naughty.config.defaults.border_width = 1
naughty.config.defaults.border_color = "#333333"
naughty.config.defaults.shape = function(cr, w, h)
    gears.shape.rounded_rect(cr, w, h, 8)
end

naughty.connect_signal("request::display", function(n)
    n.bg = "#222222"
    n.fg = "#e5e5e5"
    n.border_color = "#333333"
    n.border_width = 1
    n.margin = 8
    n.shape = function(cr, w, h)
        gears.shape.rounded_rect(cr, w, h, 8)
    end
end)

awful.spawn.with_shell("dunst &")

awful.spawn.with_shell("pkill picom; picom --config /etc/xdg/picom/picom.conf &")

awful.spawn.with_shell("xset -b &")

awful.spawn.with_shell("setxkbmap us &")

awful.spawn.with_shell("xset r rate 250 40 &")

awful.spawn.with_shell("numlockx on &")

awful.spawn.with_shell("~/.config/awesome/scripts/autostart.sh 2>/dev/null &")
