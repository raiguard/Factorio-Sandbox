local event = require("__flib__.event")

local function sensor(player)
  return {
    "",
    "Global pollution = ",
    math.ceil(player.surface.get_total_pollution()),
    " PU"
  }
end

event.on_init(function()
  if script.active_mods["StatsGui"] and remote.call("StatsGui", "version") == 1 then
    remote.call("StatsGui", "add_sensor", "Sandbox", "pollution_sensor")
  end
end)

event.on_load(function()
  if script.active_mods["StatsGui"] and remote.call("StatsGui", "version") == 1 then
    remote.call("StatsGui", "add_sensor", "Sandbox", "pollution_sensor")
  end
end)

remote.add_interface("Sandbox", {
  pollution_sensor = sensor
})
