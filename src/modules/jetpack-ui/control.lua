local event = require("__flib__.event")
local gui = require("__flib__.gui-beta")

event.on_player_created(function(e)
  local player = game.get_player(e.player_index)

  local refs = gui.build(player.gui.screen, {
    {type = "frame", style = "quick_bar_window_frame", style_mods = {width = 188}, direction = "vertical", ref = {"frame"},
      {type = "frame", style = "inside_shallow_frame",
        {
          type = "progressbar",
          style = "burning_progressbar",
          style_mods = {horizontally_stretchable = true},
          value = 0.8
        }
      },
      {type = "frame", style = "inside_shallow_frame",
        {
          type = "progressbar",
          style_mods = {horizontally_stretchable = true, color = {r = 0.3, g = 0.5, b = 1}},
          value = 0.8
        }
      }
    }
  })

  global.frame = refs.frame
end)

event.on_player_display_resolution_changed(function(e)
  local frame = global.frame
  if frame then
    local player = game.get_player(e.player_index)

    frame.location = {x = 0, y = player.display_resolution.height - ((96 + 34) * player.display_scale)}
  end
end)
