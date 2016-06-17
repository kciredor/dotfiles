local naughty = require("naughty")
local beautiful = require("beautiful")

function batteryInfo(adapter)
  local fh = io.open("/sys/class/power_supply/"..adapter.."/present", "r")
  if fh == nil then
    battery = "A/C"
    icon = ""
    percent = ""
  else
    local fcur = io.open("/sys/class/power_supply/"..adapter.."/charge_now")
    local fcap = io.open("/sys/class/power_supply/"..adapter.."/charge_full")
    local fsta = io.open("/sys/class/power_supply/"..adapter.."/status")
    local cur = fcur:read()
    local cap = fcap:read()
    local sta = fsta:read()
    fcur:close()
    fcap:close()
    fsta:close()
    battery = math.floor(cur * 100 / cap)

    if tonumber(battery) > 100 then
        battery = 100
    end

    if sta:match("Discharging") then
      icon = ""
      percent = "%"
      if tonumber(battery) < 15 then
        naughty.notify({ title    = "Battery Warning"
               , text     = "Battery low!".."  "..battery..percent.."  ".."left!"
               , timeout  = 1
               , position = "top_right"
               , fg       = beautiful.fg_focus
               , bg       = beautiful.bg_focus
        })
      end
    else
      icon = "⚡"
      percent = "%"
    end
  end
  return " "..icon..battery..percent.." "
end
