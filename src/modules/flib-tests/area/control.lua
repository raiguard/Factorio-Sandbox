local area = require("__flib__.area")
local event = require("__flib__.event")

event.on_init(function(e)
  local MyArea = area.load({left_top = {x = -5, y = -3}, right_bottom = {x = 7, y = 12}})

  MyArea:rotate()

  local position = {x = 55, y = -15}
  log(MyArea:contains_position(position))
  MyArea:expand_to_contain_position(position)
  log(MyArea:contains_position(position))

  local OtherArea = area.load({left_top = {x = -15, y = 10}, right_bottom = {x = -3, y = 12}})
  log(MyArea:contains_area(OtherArea))
  MyArea:expand_to_contain_area(OtherArea)
  log(MyArea:contains_area(OtherArea))

  rendering.draw_rectangle{
    color = {r = 0.5, g = 0.5, b = 0.5, a = 0.5},
    filled = true,
    left_top = MyArea.left_top,
    right_bottom = MyArea.right_bottom,
    surface = game.surfaces.nauvis,
    players = {1},
    draw_on_ground = true
  }

  rendering.draw_rectangle{
    color = {r = 0, g = 0.5, b = 0, a = 0.5},
    filled = true,
    left_top = OtherArea.left_top,
    right_bottom = OtherArea.right_bottom,
    surface = game.surfaces.nauvis,
    players = {1},
    draw_on_ground = true
  }

  rendering.draw_circle{
    color = {r = 0.5, g = 0, b = 0, a = 0.5},
    filled = true,
    target = position,
    radius = 0.2,
    surface = game.surfaces.nauvis,
    players = {1}
  }

  MyArea:center_on(position):rotate()

  rendering.draw_rectangle{
    color = {r = 0, g = 0, b = 0.5, a = 0.5},
    filled = true,
    left_top = MyArea.left_top,
    right_bottom = MyArea.right_bottom,
    surface = game.surfaces.nauvis,
    players = {1},
    draw_on_ground = true
  }

  local breakpoint
end)
