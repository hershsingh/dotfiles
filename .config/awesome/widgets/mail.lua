local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local mail = {}
--- Email

local path_to_icons = "/usr/share/icons/Arc/actions/22/"
local mail_icon = wibox.widget.imagebox()
mail_icon:set_image(path_to_icons .. "/mail-mark-unread.png")

-- mail_icon:set_image(awful.util.getdir("config") .. "/email-closed.png")

--mail_widget_container = wibox.widget
local mail_textbox = wibox.widget{
    align  = 'center',
    valign = 'center',
    widget = wibox.widget.textbox
}

--wibox.widget.textbox()
mail_textbox:set_font("Iosevka Bold 8")

local mail_widget = wibox.widget {
    mail_icon,
    mail_textbox ,
    layout  = wibox.layout.align.horizontal,
}

local function mail_update(widget)
   local fd = io.popen("ls ~/Maildir/INBOX/new | wc -w | tr -d '\n'")
   local mail_new = fd:read("*all")
   fd:close()
   return mail_new
end

local current_status = 0

local function update_mail_status()
   local mail_new = mail_update()
   mail_textbox:set_text("(" .. mail_new .. ")") -- .. mail_new)
   if tonumber(mail_new) == 0 then
      mail_icon:set_image(path_to_icons .. "/mail-mark-read.png")
   else
      mail_icon:set_image(path_to_icons .. "/mail-mark-unread.png")
   end
end

local mail_widget_timer = gears.timer({timeout = 1})
mail_widget_timer:connect_signal("timeout", update_mail_status)


update_mail_status()


return mail_widget
