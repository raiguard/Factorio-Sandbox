local function sensor(player)
  return {
    "",
    "Global pollution = ",
    math.ceil(player.surface.get_total_pollution()),
    " PU"
  }
end

script.on_init(function()
  if script.active_mods["StatsGui"] and remote.call("StatsGui", "version") == 1 then
    remote.call("StatsGui", "add_sensor", "MyMod", "pollution_sensor")
  end
end)

script.on_load(function()
  if script.active_mods["StatsGui"] and remote.call("StatsGui", "version") == 1 then
    remote.call("StatsGui", "add_sensor", "MyMod", "pollution_sensor")
  end
end)

remote.add_interface("MyMod", {
  pollution_sensor = sensor
})

