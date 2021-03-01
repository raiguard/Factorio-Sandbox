local event = require("__flib__.event")
local gui = require("__flib__.gui-beta")

-- EVENTS

local function draggable_frames()
  local children = {}
  for i = 1, 5 do
    children[i] = (
      {type = "frame", style = "train_schedule_station_frame", style_mods = {width = 300}, children = {
        {type = "label", caption = "This is a thing "..i},
        {type = "empty-widget", style = "flib_horizontal_pusher"},
        {
          type = "empty-widget",
          style = "draggable_space_in_train_schedule",
          style_mods = {vertically_stretchable = true},
          actions = {
            on_click = "test"
          }
        }
      }}
    )
  end
  return children
end

event.on_player_created(function(e)
  local player = game.get_player(e.player_index)
  local refs = gui.build(player.gui.screen, {
    {type = "frame", caption = "Dragging!", children = {
      {type = "frame", style = "inside_deep_frame", direction = "vertical", children = draggable_frames()}
    }}
  })
end)

-- GUI EVENTS

gui.hook_events(function(e)
  local msg = gui.read_action(e)
  if msg then
    if msg == "test" then
      game.print(serpent.line(e))
    end
  end
end)
