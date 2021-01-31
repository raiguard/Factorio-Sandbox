local event = require("__flib__.event")

event.on_player_used_capsule(function(e)
  if e.item.name == "kr-creep-virus" then
    local player = game.get_player(e.player_index)
    local surface = player.surface

    local iterator = surface.get_chunks()

    global.iterator = iterator
    global.removing_creep = true
    global.surface = surface
    game.print("REMOVING CREEP")
  end
end)

event.on_nth_tick(10, function()
  if global.removing_creep then
    local tiles_to_replace = {}
    local i = 0
    local surface = global.surface
    for _ = 1, 30 do
      local chunk = global.iterator()
      if chunk then
        for _, tile in pairs(surface.find_tiles_filtered{name = "kr-creep", area = chunk.area}) do
          i = i + 1
          tiles_to_replace[i] = {name = tile.hidden_tile or "landfill", position = tile.position}
        end
      else
        global.iterator = nil
        global.removing_creep = false
        global.surface = nil
        game.print("REMOVED CREEP")
        break
      end
    end
    surface.set_tiles(tiles_to_replace)
  end
end)
