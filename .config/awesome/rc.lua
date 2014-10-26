----------------------------------------------------------------------------------------
-- rc.lua: Awesome WM Config
----------------------------------------------------------------------------------------

gears = require("gears")
awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")

-- Widget and layout library
wibox = require("wibox")

-- Theme handling library
beautiful = require("beautiful")

-- Notification library
naughty = require("naughty")

--------------- Naughty notification properties -------------
naughty.config.defaults.font             = "Droid Sans 8"
---------------------------------------------------------------

-- {{{ ERROR HANDLING
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- Nifty funtion to debug code using naughty
function dbg(vars)
    local text = ""
    for i=1, #vars do text = text .. vars[i] .. " | " end
    naughty.notify({ text = text, timeout = 0 })
end

-- {{{ Variable definitions
homedir = os.getenv('HOME')
-- Themes define colours, icons, and wallpapers
beautiful.init(homedir .. "/.config/awesome/themes/dust/theme.lua")
--beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")
theme.wallpaper = homedir .. "/background" 
--awful.util.spawn(homedir .. "/scripts/wallsmart.sh")

theme.font = "Droid Sans 8"

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
-- THIS IS NOT THE LAYOUTS FOR YOUR TAGS
local layouts =
{
    awful.layout.suit.tile.left,
    --awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.bottom,
    awful.layout.suit.max,
    --awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    awful.layout.suit.floating
    --awful.layout.suit.max.fullscreen,
    --awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ CUSTOM: Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ "hq", "web", "music", "docs", "etc" }, s, layouts[1])
    --tags[s] = awful.tag({ 1, 2, 3, 4, 5, 6, 7, 8, 9 }, s, layouts[1])
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "Apps", xdgmenu},
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- CUSTOM: Create an empty wibox to place the conky bar
--mystatusbar = awful.wibox({ position = "bottom", screen = 1, ontop = false, width = 1, height = 16 })

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", ontop=false, screen = s})
    --mywibox[s].visible=false

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])
    --right_layout:add(powerline_widget)


    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 5, awful.tag.viewnext),
    awful.button({ }, 4, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
-- Modal Keybindings ---
info_modal_keybinds = "\
<b>Apps</b>\
    1 - Firefox\
    2 - Google Chrome\
    3 - Ncmpcpp\
    4 - Vim\
    5 - LinuxDCPP\
    6 - GoldenDict\
    7 - Dropbox\
    \
<b>Notebook</b>\
    a - Arch Notes\
    w - Remind Calendar\
    d - Dokuwiki IDE\
    f - Dokuwiki in Vim\
    s - Wordlist\
    \
<b>Quotebook</b>\
    s - Save Current Quote\
    q - Open QuoteBook\
    \
<b>Edit Config files</b>\
    l - Awesome, rc.lua\
    v - Vim, vimrc\
    \
<b>netctl</b>\
    e - Ethernet-dhcp\
    x - disconnect all profiles\
    \
<b>Stuff</b>\
    / - Mount/Dismount \"Stuff\"\
<b>Logout</b>\
    o - Turn off the monitor\
    p - Poweroff\
    [ - Reboot\
    ] - Suspend\
  ⏏ - Lock Screen\
"

 -- mapping for modal client keys
global_mode_modal_keybinds = {
    Escape = function() modal_keybinds_notification= naughty.notify({title="[~] Mode", text="Cancelled"}) end,
    -- Apps
    ["1"] = function () run_or_raise("firefox", {class="FireFox"} ) end,
    ["2"] = function () run_or_raise("google-chrome-stable", {class="Google-chrome"} ) end,
    ["3"] = function () awful.util.spawn(terminal .. ' -e "ncmpcpp"') end,
    ["4"] = function () awful.util.spawn('urxvt -e bash -ic "vim ~/scratchpad.txt"') end,
    ["5"] = function () awful.util.spawn('linuxdcpp') end,
    ["6"] = function () awful.util.spawn('goldendict') end,
    ["7"] = function () awful.util.spawn('dropboxd') end,
    -- Notebook
    ["a"] = function () awful.util.spawn('urxvt -e bash -ic "vim /srv/http/doku/data/pages/arch.txt"') end,
    ["w"] = function () awful.util.spawn('urxvt -e bash -ic "vim ~/calendars/imp.rem"') end,
    ["d"] = function () awful.util.spawn('firefox -new-window http://localhost/doku') 
        awful.util.spawn('urxvt -e vim /home/hersh/doku -c "silent cd /home/hersh/doku" -c "silent call FirefoxRefresher()"') end,
    ["f"] = function () awful.util.spawn('urxvt -e vim /home/hersh/doku -c "silent cd /home/hersh/doku"') end,
    ["s"] = function () awful.util.spawn('urxvt -e bash -ic "vim ~/notes/study/wordlist/wordlist.txt"') end,
    -- Quotebook
    ["s"] = function () awful.util.spawn(homedir .. '/scripts/getQuote/save_current_quote.sh') end,
    ["q"] = function () awful.util.spawn('urxvt -e bash -ic "vim ~/scripts/getQuote/quotesdb.txt"') end,
    -- Config Files
    ["l"] = function () awful.util.spawn('urxvt -e bash -ic "vim ~/.config/awesome/rc.lua"') end,
    ["v"] = function () awful.util.spawn('urxvt -e bash -ic "vim ~/.vimrc"') end,
    -- Netctl 
    ["e"] = function () awful.util.spawn(homedir .. '/scripts/netctlpanel.sh connect ethernet-dhcp') end,
    ["x"] = function () awful.util.spawn(homedir .. '/scripts/netctlpanel.sh disconnect') end,
    -- Stuff
    ["/"] = function () awful.util.spawn_with_shell(homedir .. '/scripts/ecryptfspanel.sh') end,
    -- Logout Options
    ["XF86Eject"] = function () awful.util.spawn("slimlock") end,
    ["o"] = function () awful.util.spawn('xset dpms force off') end,
    ["p"] = function () awful.util.spawn(homedir .. '/scripts/shutdown.sh shutdown') end,
    ["["] = function () awful.util.spawn(homedir .. '/scripts/shutdown.sh reboot') end,
    ["]"] = function () awful.util.spawn(homedir .. '/scripts/shutdown.sh suspend') end,
}

-- Setup the timer for [~] mode timeout
modal_timer = timer { timeout = 3 }
modal_timer:connect_signal("timeout", function()
  modal_timer:stop()
    if(modal_keybinds_notification) then naughty.destroy(modal_keybinds_notification) end
    modal_keybinds_notification = naughty.notify({ title = "[~] Mode", text = "I don't have all day! Operation timed out.", timeout=2 })
    keygrabber.stop()
end)

globalkeys = awful.util.table.join(
    -- CUSTOM: Program Shortcuts
    
    -- Trigger modal keybinds on Mod4+~
    awful.key({ modkey }, "~", function(c)

        -- Display info for all keybindings
        if(modal_keybinds_notification) then naughty.destroy(modal_keybinds_notification) end
        modal_keybinds_notification = naughty.notify({ title = "[~] Mode", text = info_modal_keybinds, timeout=0 })

        -- Start the timer for [~] mode timeout
        modal_timer:start()

        keygrabber.run(function(mod, key, event)
            if event == "release" then return true end

            -- Stop the timer for [~] mode timeout
            modal_timer:stop()

            keygrabber.stop()

            if(modal_keybinds_notification) then naughty.destroy(modal_keybinds_notification) end

            if global_mode_modal_keybinds[key] then global_mode_modal_keybinds[key](c) 
            else modal_keybinds_notification = naughty.notify({ title = "[~] Mode", text = "Invalid Key: <" .. key ..">", timeout=0 })
            end

            return true
        end)
    end),

    awful.key({modkey, "Shift"}, "XF86Eject", function () 
        awful.util.spawn('sudo truecrypt --force --dismount') 
        naughty.notify({text="Image unmounted."})
    end),

    awful.key({modkey, }, "XF86Eject", function () awful.util.spawn('udiskie-umount -a') end),
    awful.key({ },        "XF86Eject", function () awful.util.spawn('eject /dev/sr0') end),
    awful.key({modkey, }, "F1", function () awful.util.spawn('urxvt -e bash -ic "ranger"') end),
    awful.key({modkey, }, "b", function () mywibox[1].visible=not mywibox[1].visible end),

    -- Refresh Wallpaper
    --awful.key({modkey, }, "F10", function () 
        --gears.wallpaper.maximized( theme.wallpaper , s, true)
    --end),
    
    -- Multimedia Keys to change volume 
    -- The following is for alsamixer... am I not using pulseaudio ?
    awful.key({}, "#122", function () 
        awful.util.spawn("amixer -c 0 set Master playback 10%-")
        getVolume()
    end),
    awful.key({}, "#123", function () 
        awful.util.spawn("amixer -c 0 set Master playback 10%+")
        getVolume()
    end),
    awful.key({"Shift"}, "#122", function () 
        awful.util.spawn("amixer -c 0 set Master playback 5%-")
        getVolume()
    end),
    awful.key({"Shift"}, "#123", function () 
        awful.util.spawn("amixer -c 0 set Master playback 5%+")
        getVolume()
    end),
    awful.key({}, "#121", function () awful.util.spawn("amixer -c 0 set Master playback toggle") end),
    -- Multimedia keys to play/pause MPC etc.
    awful.key({ }, "XF86AudioNext",function () awful.util.spawn( "mpc next" ) showCurrentSong() end),
    awful.key({ }, "XF86AudioPrev",function () awful.util.spawn( "mpc prev" ) showCurrentSong() end),
    awful.key({ }, "XF86AudioPlay",function () awful.util.spawn( "mpc toggle" ) end),
    awful.key({"Shift" }, "XF86AudioNext",function () awful.util.spawn( "mpc del 0")
            naughty.notify({title="MPD", text="Deleted the current song from playlist. Moving on to the next one."})
            showCurrentSong() 
        end),
    -- Screenshot for PrintScreen Key
    awful.key({ }, "Print",function () awful.util.spawn( "import -window root " .. homedir ..  "/screenshot.png" ) end),

    -- Natural way to change tabs!
    awful.key({ modkey,           }, "Tab",   awful.tag.viewnext       ),
    awful.key({ modkey,"Shift"    }, "Tab",   awful.tag.viewprev       ),
    -- -- --

    -- Tag movement
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ "Mod1",           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    --awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

     --Awesome MenuBar
    --awful.key({ modkey }, "p", function () menubar.show() end),

    awful.key({ modkey }, "F12", function () awful.util.spawn("slimlock") end),
    --awful.key({ modkey }, "Escape" function () menubar.exit() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end)
    -- Menubar
    --awful.key({ modkey }, "p", function() menubar.show() end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  
                                                            mywibox[1].visible = not c.fullscreen 
                                                        end),
    awful.key({ modkey,           }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     size_hints_honor = false, -- Needed so that a maximized terminal window takes up full space
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
     { rule = { class = "Firefox", class = "Google-chrome" },
       properties = { tag = tags[1][2] } },
     { rule = { class = "urxvt", role = "todo" },
       properties = { tag = tags[1][5] } },
     --{ rule = { class = "Gnome-terminal", role="transparent_wallpaper" }, 
       --properties = {   tag = tags[1][1],
                        --border_width=0,
                        --floating=true,
                        --below=true,     --below all other windows
                        ----hidden=true, -- makes it totally invisivle
                        --focus=true,
                        --geometry = {x=0, width=1000, y=19, height=800}
                    --} 
                --},

     --{ rule = { class = "Gnome-terminal", role="ncmpcpp" }, 
                   --properties = {   tag = tags[1][3],
                                    --floating=true,
                                    --border_width=0,
                                    --below=true,     --below all other windows
                                    ----hidden=true, -- makes it totally invisivle
                                    --focus=true,
                                    --geometry = {x=33, width=940, y=110, height=615}
                                --}}
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Focus the latest client
    client.focus = c; c:raise()

     --Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c; c:raise()
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) 
    --c.border_color = beautiful.border_focus
    c.border_color = "#0097FF"
    c.opacity = 1.0
end)
client.connect_signal("unfocus", function(c) 
    c.border_color = beautiful.border_normal
    c.opacity = 0.9
end)
-- }}}

-- MORE CUSTOMIZATIONS --
last_mpd_notification =0 
function getVolume()
    local fd=io.popen('amixer -c 0 get Master|tail -n1|sed -E "s/.*\\[([0-9]+)\\%\\].*/\\1/"|tr "\\n" " "')
    local vol = fd:read("*all")
    fd:close()
    last_vol_notification = naughty.notify({title="Volume", text=vol.."%", timeout=.5, replaces_id=last_vol_notification}).id
end

function showCurrentSong() 
    local fd = io.popen("mpc -f '%artist% - %title%' | head -n 1")
    local status = fd:read("*all")
    fd:close()

    -- using ID ensures that mpd notifications dont flood the screen and only replaces the older notificaitons
    last_mpd_notification = naughty.notify({ title = "MPD", text=status, replaces_id = last_mpd_notification}).id
end

----------------------------------------
--from https://wiki.archlinux.org/index.php/Awesome
-- to keep support for some gnome apps
function start_daemon(dae)
	daeCheck = os.execute("ps -eF | grep -v grep | grep -w " .. dae)
	if (daeCheck ~= 0) then
		os.execute(dae .. " &")
	end
end

procs = {"volumeicon"}
--procs = {"gnome-settings-daemon", "nm-applet", "kupfer", "gnome-sound-applet", "gnome-power-manager"}
--for k = 1, #procs do
	--start_daemon(procs[k])
--end
----------------------------------------
-- Functions to spawn programs

function run_once(cmd)
  findme = cmd
  firstspace = cmd:find(" ")
  if firstspace then
    findme = cmd:sub(0, firstspace-1)
  end
  awful.util.spawn_with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
end

function run_or_raise(cmd, properties)
   local clients = client.get()
   local focused = awful.client.next(0)
   local findex = 0
   local matched_clients = {}
   local n = 0
   for i, c in pairs(clients) do
      --make an array of matched clients
      if match(properties, c) then
         n = n + 1
         matched_clients[n] = c
         if c == focused then
            findex = n
         end
      end
   end
   if n > 0 then
      local c = matched_clients[1]
      -- if the focused window matched switch focus to next in list
      if 0 < findex and findex < n then
         c = matched_clients[findex+1]
      end
      local ctags = c:tags()
      
      -- table.getn(ctags) stopped working with Awesome 3.5. Replace that with #ctags
      if #ctags == 0 then
         -- ctags is empty, show client on current tag
         local curtag = awful.tag.selected()
         awful.client.movetotag(curtag, c)
      else
         -- Otherwise, pop to first tag client is visible on
         awful.tag.viewonly(ctags[1])
      end
      -- And then focus the client
      client.focus = c
      c:raise()
      return
   end
   awful.util.spawn(cmd)
end

function run_if_not_running(cmd, properties)
    local clients = client.get()
    for i, c in pairs(clients) do
        --A very nice way to list all matching windows
            --naughty.notify({title=c.class,text=c.role})
            --naughty.notify({tilte="run if not running: ", text="" .. i})
            --naughty.notify({tilte="run if not running: ", text=c.class .. c.instance})
            
          if match(properties, c) then
              --dbg({"found"})
              return
          end
    end
    --dbg({"not found"})
    awful.util.spawn(cmd)
end

-- Returns true if all pairs in table1 are present in table2
function match (table1, table2)
    if not table2 or not table1 then
        return false
    end
   for k, v in pairs(table1) do
       if table2[k] then   -- This finally solved the problem of "nil" values being accessed.
                           -- eg: Some windows just don't have any "role" assigned, and that is what caused problems
          if table2[k] ~= v and not table2[k]:find(v) then
             return false
          end
      end

   end
   return true
end
-----------------------------------------------
---------------------------------------------
-- A nice function to get properties of focused clients
mytimer=timer{timeout=2}
mytimer:connect_signal("timeout",
        function () for i,c in ipairs(client.get(mouse.screen)) do
                        if c:tags()[mouse.screen]== awful.tag.selected(mouse.screen) then
                                dbg({c.class, c.role, c.instance})
                                --naughty.notify({title=c.class,text=c.role})
                                --naughty.notify({title=c.class,text=c.instance})
                                end
                    end
        end)

-----------------------------------------------------
-- Startup Stuff

-- Composite Manager - required for transparency effects
--run_once("xcompmgr &") --run_once("unagi &")
-- Impersonate another non-reparenting WM recognized by Java VM. Required to make MATLAB work.
--run_once("wmname LG3D &")
--run_once("pasystray &")
--run_once("unclutter &")

-- start the transparent terminal.. the settings for this are in the particular profile
--run_or_raise("gnome-terminal --role=transparent_wallpaper --profile=transparent_wallpaper", {role="transparent_wallpaper"})
