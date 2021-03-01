local area = require("__flib__.area")
local event = require("__flib__.event")

event.on_selected_entity_changed(function(e)
  local player = game.get_player(e.player_index)

  if global.rectangle then
    rendering.destroy(global.rectangle)
    global.rectangle = nil
  end
  if global.secondary_rectangle then
    rendering.destroy(global.secondary_rectangle)
    global.secondary_rectangle = nil
  end

  local entity = player.selected
  if entity then
    local BoundingBox = area.load(entity.bounding_box)
    global.rectangle = rendering.draw_rectangle{
      color = {r = 0.5, g = 0.5, b = 0, a = 0.5},
      filled = true,
      left_top = BoundingBox.left_top,
      right_bottom = BoundingBox.right_bottom,
      surface = entity.surface,
      players = {e.player_index},
      only_in_alt_mode = true
    }

    local secondary = entity.secondary_bounding_box
    if secondary then
      local SecondaryBox = area.load(secondary)
      global.secondary_rectangle = rendering.draw_rectangle{
        color = {r = 0.5, g = 0.5, b = 0, a = 0.5},
        filled = true,
        left_top = SecondaryBox.left_top,
        right_bottom = SecondaryBox.right_bottom,
        surface = entity.surface,
        players = {e.player_index},
        only_in_alt_mode = true
      }
    end
  end
end)

event.on_built_entity(function(e)
  local player = game.get_player(e.player_index)
  local entity = e.created_entity

  if entity.type == "straight-rail" or entity.type == "curved-rail" then
    rendering.draw_circle{
      color = {r = 1},
      surface = entity.surface,
      target = entity.position,
      filled = true,
      players = {player},
      radius = 0.1
    }
    local tile_area = area.from_position(entity.position)
    rendering.draw_rectangle{
      color = {r = 0.5, g = 0, b = 0.5, a = 0.5},
      filled = true,
      surface = entity.surface,
      left_top = tile_area.left_top,
      right_bottom = tile_area.right_bottom,
      players = {e.player_index}
    }
    rendering.draw_text{
      text = entity.direction,
      surface = entity.surface,
      target = entity.position,
      color = {r = 1, g = 1, b = 1},
      scale = 1,
      players = {player},
      alignment = "center"
    }
  end
end)
