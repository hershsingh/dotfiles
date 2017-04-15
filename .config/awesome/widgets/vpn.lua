local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

local vpn_widget = wibox.widget{
   widget = wibox.widget.textbox,
   font = "Iosevka Bold 8",
   markup = "VPN: Off",
}

local function update_vpn_status()
   status = io.popen("pgrep openvpn", "r")
   if status:read() == nil then
      vpn_widget:set_markup(" <span color='#FF2A2A'>VPN: OFF</span> ")
   else
      vpn_widget:set_markup(" <span color='#00FF00'>VPN: ON</span> ")
   end
   status:close()    
   return true
end    

vpn_timer = gears.timer.start_new(2, update_vpn_status)

update_vpn_status()

return vpn_widget
