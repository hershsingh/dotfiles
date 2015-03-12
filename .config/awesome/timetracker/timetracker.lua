-- Parameters
filename_timetracker = homedir .. '/timetracker.txt'
--filename_tracker_result = homedir .. '/timetracker_result.txt'
local timetracker_lastenter = 0
local timetracker_lastexit = 0
local timetracker_result=0
local timetracker_offset=0

-- Tracker file
--local f_tracker = io.open(filename_tracker_result, 'w')
--f_tracker:write('0')
--f_tracker:close()

-- Define the work tag
work_tag = 8
tags[1][work_tag].name = ' work '

-- Connect to the property::selected signal, 
-- triggered whenever the tag is selected/deselected.
tags[1][work_tag]:connect_signal("property::selected", function(tag)

        -- If the tag was selected
        if tag.selected then
            timetracker_lastenter = os.time()
            --f_timetracker:write('' .. timetracker_lastenter)
            
        -- If the tag was deselected
        else
            --local f_tracker = io.open(filename_tracker_result, 'r')
            --timetracker_result = tonumber(f_tracker:read("*all"))
            --naughty.notify({ text=timetracker_result})
            --f_tracker:close()
            
            -- Record the exit time
            timetracker_lastexit = os.time()

            --f_timetracker:write('-' .. timetracker_lastexit .. '\n')

            -- Display time spent in work_tag using a notification
            timetracker_result = timetracker_result + (timetracker_lastexit - timetracker_lastenter)
            local tt_hours = math.floor(timetracker_result/3600)
            local tt_minutes = math.floor((timetracker_result%3600)/60)
            local tt_seconds = timetracker_result - tt_hours*3600 - tt_minutes*60
            local tt_result = tostring(tt_hours) .. ':' .. tostring(tt_minutes) .. ':' .. tostring(tt_seconds)
            naughty.notify({ text=tt_result})

            -- Write the time spent to the tracker file
            local f_timetracker = io.open(filename_timetracker, 'w')
            f_timetracker:write(tostring(timetracker_result) .. '\n')
            f_timetracker:close()
        end
end) 

