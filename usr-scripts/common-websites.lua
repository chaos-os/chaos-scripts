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

local website_links = nil
for _, val in ipairs(config.bookmarks) do
    if not website_links then
        website_links = val
    else
        website_links = string.format("%s\n%s", website_links, val)
    end
end

local website_link = os_capture(string.format("echo -e '%s' | dmenu -p 'web' -l 20", website_links))

if website_links == "" then
    os.exit(0)
else
    os.execute(string.format("xdg-open %s &", website_link))
end
