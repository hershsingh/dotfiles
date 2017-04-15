local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")

local volume = {}

local volume_widget = wibox.widget {
    {
        id = "progressbar",
        max_value     = 1,
        value         = 0.33,
        widget        = wibox.widget.progressbar,
        margins = 3,
        background_color = '#494B4F',
        color = '#AECF96'
    },
    forced_width  = 16,
    direction     = 'east',
    layout        = wibox.container.rotate,
}
local volume_widget_progressbar = volume_widget:get_children_by_id("progressbar")[1]
local volume_tooltip = awful.tooltip({ objects = { volume_widget }})

local function getVolume()
    local fd=io.popen('amixer get Master|tail -n1|sed -E "s/.*\\[([0-9]+)\\%\\].*/\\1/"|tr "\\n" " "')
    local vol = fd:read("*all")
    fd:close()

    last_vol_notification = naughty.notify({title="Volume", text=vol.."%", timeout=.5, replaces_id=last_vol_notification}).id

    local vol_num = (tonumber(vol)/100)
    volume_widget_progressbar:set_value(vol_num)
    volume_tooltip:set_text("Volume: " .. vol)
end

local function getWidget()
   return volume_widget
end

volume.getWidget = getWidget
volume.getVolume = getVolume

getVolume()

return volume
