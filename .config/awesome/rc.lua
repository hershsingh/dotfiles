-- Emacs keybinding to reload Awesome in a Xephyr instance on display :5
-- (evil-leader/set-key "a" '(lambda() (interactive) (shell-command "DISPLAY=:5 xdotool key ctrl+super+r")))

-- Standard awesome library

local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
require("awful.rules")

-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget

-- {{{ Error handling
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
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
--
-- Get the user home directory
homedir = os.getenv('HOME')

-- Themes define colours, icons, font and wallpapers.
beautiful.init(awful.util.get_themes_dir() .. "default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "nano"
--editor_cmd = terminal .. " -e " .. editor
editor_cmd = "emacsclient -c"

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    -- awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    awful.layout.suit.floating,
}
-- }}}

--- {{{ Wallpaper
-- Set the ~/background as the wallpaper if it exists

function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

local wallpaper
local wallpaper_vertical

if file_exists(homedir .. "/background") then
    wallpaper = homedir .. "/background" 
end
if file_exists(homedir .. "/background_vertical") then
    wallpaper_vertical = homedir .. "/background_vertical" 
end

--- }}}

--- {{{ More wigets

-- Battery
local battery_widget = require "widgets/battery"

-- Volume
local volume = require "widgets/volume"
local volume_widget = volume.getWidget()
local getVolume = volume.getVolume

-- Email
local mail_widget = require "widgets/mail"

-- VPN
local vpn_widget = require "widgets/vpn"

--- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

-- Create a wibox for each screen and add it
local taglist_buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
     
    local this_wallpaper

    if beautiful.wallpaper then
    -- Check if screen is vertical
        if (s.geometry.width < s.geometry.height) and (wallpaper_vertical) then
            this_wallpaper = wallpaper_vertical
        else 
            this_wallpaper = wallpaper
        end
        -- If wallpaper is a function, call it with the screen
        --if type(wallpaper) == "function" then
            --wallpaper = wallpaper(s)
        --end
        gears.wallpaper.maximized(this_wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

local widget_seperator = wibox.widget.textbox(" | ")

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    --awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
    awful.tag({ "1", "2", "3", "4", "5"}, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    -- show only non-empty tags on taglist (dynamic tagging)
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mylauncher,
            s.mytaglist,
            s.mypromptbox,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mail_widget,
            wibox.widget.textbox(" | "),
            battery_widget,
            widget_seperator,
            vpn_widget,
            widget_seperator,
            volume_widget,
            widget_seperator,
            mytextclock,
            s.mylayoutbox,
            wibox.widget.systray(),
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

--- {{{ Modal Keybindings
info_modal_keybinds = "\
<b>Apps</b>\
    1 - Firefox\
    2 - Google Chrome\
    3 - Emacsclient\
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
    n - select netctl profile\
    x - disconnect all profiles\
    \
<b>Stuff</b>\
    / - Mount/Dismount \"Stuff\"\
<b>Logout</b>\
    o - Turn off the monitor\
    p - Poweroff\
    [ - Reboot\
    ] - Suspend\
  Del - Lock Screen\
"

 -- mapping for modal client keys
global_mode_modal_keybinds = {
    Escape = function() modal_keybinds_notification= naughty.notify({title="[~] Mode", text="Cancelled"}) end,
    -- Apps
    ["1"] = function () run_or_raise("firefox", {class="FireFox"} ) end,
    ["2"] = function () run_or_raise("google-chrome-stable", {class="Google-chrome"} ) end,
    --["3"] = function () awful.util.spawn(terminal .. ' -e "ncmpcpp"') end,
    ["3"] = function () awful.util.spawn("emacsclient -c") end,
    ["4"] = function () awful.util.spawn('urxvt -e bash -ic "vim ~/scratchpad.txt"') end,
    ["5"] = function () awful.util.spawn('linuxdcpp') end,
    ["6"] = function () awful.util.spawn('goldendict') end,
    ["7"] = function () awful.util.spawn('dropboxd') end,
    -- Notebook
    ["a"] = function () awful.util.spawn('emacsclient -c ~/org/arch.org') end,
    ["w"] = function () awful.util.spawn('urxvt -e bash -ic "vim ~/calendars/imp.rem"') end,
    ["d"] = function () awful.util.spawn('firefox -new-window http://localhost/doku') 
        awful.util.spawn('urxvt -e vim /home/hersh/doku -c "silent cd /home/hersh/doku" -c "silent call FirefoxRefresher()"') end,
    ["f"] = function () awful.util.spawn('urxvt -e vim /home/hersh/doku -c "silent cd /home/hersh/doku"') end,
    ["s"] = function () awful.util.spawn('urxvt -e bash -ic "vim ~/notes/study/wordlist/wordlist.txt"') end,
    -- Quotebook
    ["s"] = function () awful.util.spawn(homedir .. '/scripts/getQuote/save_current_quote.sh') end,
    ["q"] = function () awful.util.spawn('urxvt -e bash -ic "vim ~/scripts/getQuote/quotesdb.txt"') end,
    -- Config Files
    ["l"] = function () awful.util.spawn(editor_cmd .. " ~/.config/awesome/rc.lua") end,
    ["v"] = function () awful.util.spawn('urxvt -e bash -ic "vim ~/.vimrc"') end,
    -- Netctl 
    ["e"] = function () awful.util.spawn(homedir .. '/scripts/netctlpanel.sh connect ethernet-dhcp') end,
    ["n"] = function () awful.util.spawn(homedir .. '/scripts/netcon.sh') end,
    ["x"] = function () awful.util.spawn(homedir .. '/scripts/netctlpanel.sh disconnect') end,
    -- Stuff
    ["/"] = function () awful.util.spawn_with_shell(homedir .. '/scripts/ecryptfspanel.sh') end,
    -- Logout Options
    ["XF86Eject"] = function () awful.util.spawn("slock") end,
    ["Delete"] = function () awful.util.spawn("slock") end,
    ["o"] = function () awful.util.spawn('xset dpms force off') end,
    ["p"] = function () awful.util.spawn(homedir .. '/scripts/shutdown.sh shutdown') end,
    ["["] = function () awful.util.spawn(homedir .. '/scripts/shutdown.sh reboot') end,
    ["]"] = function () awful.util.spawn(homedir .. '/scripts/shutdown.sh suspend') end,
}

-- Setup the timer for [~] mode timeout
modal_timer = gears.timer { timeout = 3 }
modal_timer:connect_signal("timeout", function()
  modal_timer:stop()
    if(modal_keybinds_notification) then naughty.destroy(modal_keybinds_notification) end
    modal_keybinds_notification = naughty.notify({ title = "[~] Mode", text = "I don't have all day! Operation timed out.", timeout=2 })
    keygrabber.stop()
end)

--- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(

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

     -- Brightness
    awful.key({ }, "XF86MonBrightnessDown", function ()
        awful.util.spawn("xbacklight -dec 10") 
        getBrightness()
    end),
    awful.key({ }, "XF86MonBrightnessUp", function ()
        awful.util.spawn("xbacklight -inc 10") 
        getBrightness()
    end),

    -- Natural way to change tabs!
    awful.key({ modkey,           }, "Tab",   awful.tag.viewnext       ),
    awful.key({ modkey,"Shift"    }, "Tab",   awful.tag.viewprev       ),

    -- Screenshot for PrintScreen Key
    awful.key({modkey, }, "Print",function () awful.util.spawn( "import " .. homedir ..  "/screenshot" .. os.date("_%y-%m-%d_%H-%M-%S").. ".png" ) end),

    -- Multimedia Keys to change volume 
    -- The following is for alsamixer... am I not using pulseaudio ?
    awful.key({}, "#122", function () 
        awful.util.spawn("amixer set Master playback 10%-", false)
        getVolume()
    end),
    awful.key({}, "#123", function () 
        awful.util.spawn("amixer set Master playback 10%+", false)
        getVolume()
    end),
    awful.key({"Shift"}, "#122", function () 
        awful.util.spawn("amixer set Master playback 5%-", false)
        getVolume()
    end),
    awful.key({"Shift"}, "#123", function () 
        awful.util.spawn("amixer set Master playback 5%+", false)
        getVolume()
    end),
    awful.key({}, "#121", function () awful.util.spawn("amixer -c 0 set Master playback toggle") end),

    -- Custom keys
    awful.key({modkey, }, "XF86Eject", function () awful.util.spawn('udiskie-umount -a') end),
    awful.key({ },        "XF86Eject", function () awful.util.spawn('eject /dev/sr0') end),
    awful.key({modkey, }, "F1", function () awful.util.spawn('urxvt -e "ranger"') end),
    awful.key({modkey, }, "b", function () mywibox[1].visible=not mywibox[1].visible end),

    -- Default  keys
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, "Shift"   }, "Tab",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Tab",  awful.tag.viewnext,
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
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
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
    -- awful.key({ "Control"         }, "Tab",
    --     function ()
    --         awful.client.focus.history.previous()
    --         if client.focus then
    --             client.focus:raise()
    --         end
    --     end,
    --     {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    -- awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              -- {description = "run prompt", group = "launcher"}),
    -- Prompt
    awful.key({ modkey },            "r",     function ()  awful.util.spawn('rofi -now -show run -terminal urxvt') end),
    -- awful.key({ modkey },            "w",     function ()  awful.util.spawn('rofi -now -show window -terminal urxvt') end),

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
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local num_tags = 5
for i = 1, num_tags do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Remove titlebars from normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
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
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
--
--
--
--

client.connect_signal("focus", function(c) 
    --c.border_color = beautiful.border_focus
    c.border_color = "#0097FF"
    c.opacity = 1.0
end)
client.connect_signal("unfocus", function(c) 
    c.border_color = beautiful.border_normal
    c.opacity = 0.9
end)
-- Show the current brighness level using a notification
function getBrightness()
    local fd = io.popen("xbacklight -get")
    --local fd = io.open("/sys/class/backlight/intel_backlight/brightness", "r")
    local status = fd:read("*all")
    fd:close()
    last_brightness_notification = naughty.notify({ title = "Brightness", text=status, replaces_id = last_brightness_notification}).id
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

-- Nifty funtion to debug code using naughty
local function dbg(vars)
    local text = ""
    for i=1, #vars do text = text .. vars[i] .. " | " end
    naughty.notify({ text = text, timeout = 0 })
end

