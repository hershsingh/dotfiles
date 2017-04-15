local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

-- Create a widget and update its content using the output of a shell
-- command every 10 seconds:
local battery = {}

-- Colors
local pb_margins = 4

local discharging_color = "#90aacc"
local discharging_bg_color = "#586677"

local low_color = "#f76060"
local low_bg_color = "#724242"

local charging_color = "#9bddb0"
local charging_bg_color = "#435e4c"

local function make_battery_widget(id_string)
   return {
        id = id_string,
        min_value    = 0,
        max_value    = 100,
        value        = 0,
        paddings     = 2,
        border_width = 0,
        forced_width = 30,
        margins = pb_margins,
        widget       = wibox.widget.progressbar,
      }
end

local battery_widget = wibox.widget {
   make_battery_widget("mypb0"),
   make_battery_widget("mypb1"),
   layout      = wibox.layout.align.horizontal,
   set_battery = function(self, val0, val1)
      self.mypb0.value = tonumber(val0)
      self.mypb1.value = tonumber(val1)
   end,
}

local function read_file(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read("*all") -- *a or *all reads the whole file
    file:close()
    return content
end

local function get_battery_status()
   local bat0 = read_file("/sys/class/power_supply/BAT0/capacity")
   local bat1 = read_file("/sys/class/power_supply/BAT1/capacity")
   local ac = read_file("/sys/class/power_supply/AC/online")

   battery_widget:set_battery(bat0, bat1)

   if tonumber(ac) == 1 then
      battery_widget.mypb0.color = charging_color
      battery_widget.mypb0.background_color = charging_bg_color

      battery_widget.mypb1.color = charging_color
      battery_widget.mypb1.background_color = charging_bg_color
   else
      if tonumber(bat0)<25 then
         battery_widget.mypb0.color = low_color
         battery_widget.mypb0.background_color = low_bg_color
      else
         battery_widget.mypb0.color = discharging_color
         battery_widget.mypb0.background_color = discharging_bg_color
      end

      if tonumber(bat1)<25 then
         battery_widget.mypb1.color = low_color
         battery_widget.mypb1.background_color = low_bg_color
      else
         battery_widget.mypb1.color = discharging_color
         battery_widget.mypb1.background_color = discharging_bg_color
      end
   end
end

local battery_timer = gears.timer.start_new(10,
    function()
       get_battery_status()
       return true
    end
)

local function show_battery_status()
   local fd = io.popen("acpi")
   local acpi_output = fd:read("*all")
   fd:close()
   return acpi_output
end

local battery_tooltip = awful.tooltip({ objects = { battery_widget },
                                        timer_function = show_battery_status})

get_battery_status()
return battery_widget
