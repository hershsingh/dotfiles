local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")

-- Create a widget and update its content using the output of a shell
-- command every 10 seconds:
local battery = {}

local battery_widget = wibox.widget {
    {
        min_value    = 0,
        max_value    = 100,
        value        = 0,
        paddings     = 2,
        border_width = 0,
        forced_width = 30,
        forced_height = 0,
        border_color = "#000000",
        color = "#76fc98", 
        background_color =  "#488e5a",
   --shape         = gears.shape.rounded_bar,
        id           = "mypb0",
        widget       = wibox.widget.progressbar,
    },
    {
        min_value    = 0,
        max_value    = 100,
        value        = 0,
        paddings     = 2,
        border_width = 0,
        forced_width = 30,
        forced_height = 0,
        border_color = "#000000",
        color = "#76fc98", 
        background_color =  "#488e5a",
   --shape         = gears.shape.rounded_bar,
        id           = "mypb1",
        widget       = wibox.widget.progressbar,
    },
    --{
        --id           = "mytb",
        --text         = "100%",
        --font        = "Iosevka 6",
        --widget       = wibox.widget.textbox,
        --align       = 'center',
        --valign      = 'center', 
        ----color       = "#000000",
    --},
    layout      = wibox.layout.align.horizontal,
    set_battery = function(self, val0, val1)
        --self.mytb.text  = tonumber(val).."%"
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
   battery_widget:set_battery(bat0, bat1)
end

local battery_timer = gears.timer.start_new(10,
    function()
       -- battery_widget:set_battery("90")
       -- naughty.notify({text="battery"})
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
