-- Format
--https://aeg-dev.github.io/AegiSite/docs/3.2/ass_tags/
local ov = mp.create_osd_overlay("ass-events")
local style1 = [[{\fs70\an9\bord5}]]
local style2 = [[{\fs50\an9}]]

function update_ov()
  local now = os.time()
  local remaining = mp.get_property_native("duration") - mp.get_property_native("playback-time")
  -- current_time.data = os.date("%H:%M", now)

  ov.data = table.concat({
    style1 .. os.date("%H:%M", now),
    style2 .. os.date("Ends at: %H:%M", now + remaining),
    [[{\fs100\an5}⏸]],
  }, "\n")

  ov:update()
end

local timer = mp.add_periodic_timer(1, update_ov)

local fullscreen = true

function on_pause_change(name, value)
  -- PAUSE
  if value == true then
    fullscreen = mp.get_property_native("fullscreen")
    mp.set_property("fullscreen", "no")
    mp.commandv("script-message", "osc-visibility", "always", "")
    -----
    ov:update()
    update_ov()
    timer:resume()

  -- PLAY
  else
    if fullscreen == true then
      mp.set_property("fullscreen", "yes")
    end
    mp.commandv("script-message", "osc-visibility", "auto", "")
    -----
    timer:stop()
    ov:remove()
  end
end

mp.observe_property("pause", "bool", on_pause_change)
