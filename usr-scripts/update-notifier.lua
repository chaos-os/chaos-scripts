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

local function sleep(n)
	os.execute("sleep " .. tonumber(n))
end

while true do
	if tonumber(os_capture("checkupdates | wc -l")) >= config.threshold then
		os.execute("dunstify 'New updates available!!' -u 'normal'")
	else
		os.exit(0)
	end
	sleep(config.notify_timer)
end
