#!/usr/bin/env lua

package.path = "/etc/neon-os/.config/script-dependencies/config.lua"

local config = require("config")

local function os_capture(cmd)
    local f = assert(io.popen(cmd, "r"))
    local s = assert(f:read("*a"))
    f:close()
    s = string.gsub(s, "^%s+", "")
    s = string.gsub(s, "%s+$", "")
    s = string.gsub(s, "[\n\r]+", " ")
    return s
end

if os_capture("acpi | grep 'Battery'") == "" then
    os.exit(0)
end

while true do
    N = os_capture("acpi | cut -d ' ' -f4 | cut -d ',' -f1 | cut -d '%' -f1")
    M = os_capture("acpi | cut -d ' ' -f3 | cut -d ',' -f1")
    if N <= "30" and M ~= "Charging" then
        os_capture("dunstify 'please plug in your charger' -u 'critical'")
    elseif N >= "85" and M == "Charging" then
        os_capture("dunstify 'please plug out your charger' -u 'low'")
    end
    os.execute("sleep" .. " " .. config.bat_notify_timer)
end
