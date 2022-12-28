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

local website_names = nil
for key in pairs(config.search_engines) do
    if not website_names then
        website_names = key
    else
        website_names = website_names .. "\n" .. key
    end
end

local search_engine_name = os_capture(string.format("echo -e '%s' | dmenu -l 20 -p 'search engine: '", website_names))

if search_engine_name == "" then
    os.exit(0)
end

local search_keywords = os_capture(string.format("echo '' | dmenu -p %s -i", search_engine_name))

if search_keywords == "" then
    os.exit(0)
else
    local lk = config.search_engines[search_engine_name]
    os.execute(string.format("xdg-open %s%s%s", lk.Link, search_keywords:gsub(" ", lk.Seperator), lk.args))
end
