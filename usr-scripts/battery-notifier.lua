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
		os_capture(
			"dunstify 'battery running low' 'please plug in your charger' --urgency=critical --icon=/usr/share/icons/Numix/16/status/battery-030.svg"
		)
	elseif N >= "85" and M == "Charging" then
		os_capture("dunstify 'battery reached limit' 'please plug out your charger' --urgency=low --icon=/usr/share/icons/Numix/16/status/battery-100.svg")
	end
	os.execute("sleep" .. " " .. config.bat_notify_timer)
end
