-- get device number, see:
-- http://unix.stackexchange.com/a/44250/27359
-- stat -c "%d" /home
local function get_device_number(path)
  local file = io.popen('stat -c "%d" '..path)
  local dn = file:read("*a")
  file:close()
  return dn
end

local root_dn = get_device_number("/")
local home_dn = get_device_number("/home")

local function get_fs_info(fs)
  local str = "${fs_free " .. fs.. "}/${fs_size "..fs.."} Use: ${fs_used_perc "..fs.."}%";
  return "("..fs..")" .. conky_parse(str)
end

--[[
function get_devices()
  -- parse /proc/net/arp
  -- ls -l /sys/class/net/
  local info = {}
  local file = io.popen("cat /proc/net/arp | tail -n +2")
  for line in file:lines() do
    local addr, hw, flags, mac, mask, name =
      line:match("(%g+)%s+(%g+)%s+(%g+)%s+(%g+)%s+(%g+)%s+(%g+)%s*")
    info[#info+1] = name .. " " .. addr
  end
  file:close()
  return info
end
]]

local function trim(s)
  -- from PiL2 20.4
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

local function read_file(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return trim(content)
end


local function get_interfaces()
  local interfaces = {}
  local file = io.popen('stat -c "%N" /sys/class/net/*')

  for line in file:lines() do
    if not string.find(line, "/virtual/") then
      local name, path = line:match("'/sys/class/net/(%g+)'%s+%->%s+'(%g+)'%s*")
      local isUp = read_file("/sys/class/net/"..name.."/operstate")

      -- Show info only if up
      if isUp == "up" then
        local speed = read_file("/sys/class/net/"..name.."/speed")
        interfaces[#interfaces+1] = name .. conky_parse(" ${addr "..name.."}") .. " (" .. speed .. "Mb/s)"
      end
    end
  end
  file:close()
  return interfaces
end


function conky_main()

  -- Get filesystem info
  local segments = {get_fs_info("/")}
  if home_dn ~= root_dn then
    --table.insert(segments, fs_home)
    segments[#segments+1] = get_fs_info("/home")
  end

  -- Get network info
  for _, v in pairs(get_interfaces()) do
    segments[#segments+1] = v
  end

  -- CPU
  segments[#segments+1] = "CPU " .. conky_parse("${cpu cpu0}% ${freq_g}GHz");

  -- RAM
  segments[#segments+1] = "RAM " .. conky_parse("${memperc}% ${mem}/${memmax}");

  -- Date
  segments[#segments+1] = conky_parse("${time %a %d-%m-%Y} ${time %H:%M}");

  -- Battery
  if conky_parse("${if_existing /sys/class/power_supply/BAT0}1${else}0${endif}") == "1" then
    segments[#segments+1] = conky_parse("${battery_short BAT0}")
  end

  io.write(table.concat(segments, " | "))

--[[(/) ${fs_free /}/${fs_size /} Use: ${fs_used_perc /}% | \
# Free space on home
(/home)${fs_free /home}/${fs_size /home} Use: ${fs_used_perc /home}% | \
# Ethernet status
${if_up net0}net0 ${addr net0}(${exec ethtool net0 | awk '/Speed:/ {print $2}'}) | ${endif}\
# Wireless status
${if_up wifi0}wifi0 ${addr wifi0}(${exec iwconfig wifi0 | egrep -o '[0-9]+(\.[0-9])? Mb/s'}) | ${endif}\
]]

end
