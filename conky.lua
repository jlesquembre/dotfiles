

-- get device number, see:
-- http://unix.stackexchange.com/a/44250/27359
-- stat -c "%d" /tmp
-- stat -c "%d" /home


function get_fs_info(fs)
  local str = "${fs_free " .. fs.. "}/${fs_size "..fs.."} Use: ${fs_used_perc "..fs.."}%"
  return "("..fs..")" .. conky_parse(str)
end

function conky_main()
  local uptime = conky_parse("${uptime}")
  --local fs_root = "(/)" .. conky_parse("${fs_free /}/${fs_size /} Use: ${fs_used_perc /}%")
  --local fs_home = "(/home)" .. conky_parse("${fs_free /}/${fs_size /} Use: ${fs_used_perc /}%")
  local fs_root = get_fs_info("/")
  local fs_home = get_fs_info("/home")
  local segments = {fs_root}
  table.insert(segments, fs_home)
  --segments[#segments+1] = fs_home
  print(table.concat(segments, " | "))

--[[(/) ${fs_free /}/${fs_size /} Use: ${fs_used_perc /}% | \
# Free space on home
(/home)${fs_free /home}/${fs_size /home} Use: ${fs_used_perc /home}% | \
# Ethernet status
${if_up net0}net0 ${addr net0}(${exec ethtool net0 | awk '/Speed:/ {print $2}'}) | ${endif}\
# Wireless status
${if_up wifi0}wifi0 ${addr wifi0}(${exec iwconfig wifi0 | egrep -o '[0-9]+(\.[0-9])? Mb/s'}) | ${endif}\
]]

  --print ("this is inside the function")
end
