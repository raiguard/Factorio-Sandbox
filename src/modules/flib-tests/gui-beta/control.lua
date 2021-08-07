local event = require("__flib__.event")
local gui = require("__flib__.gui-beta")
local mod_gui = require("mod-gui")

local todo_gui = require("modules.flib-tests.gui-beta.todo")

event.on_init(function()
  global.players = {}
end)

event.on_player_created(function(e)
  -- create player table
  global.players[e.player_index] = {}
  local player_table = global.players[e.player_index]

  local player = game.get_player(e.player_index)

  -- CREATE GUIS

  gui.build(mod_gui.get_button_flow(player), {
    {
      type = "button",
      style = mod_gui.button_style,
      caption = "TodoMVC",
      actions = {
        on_click = "toggle_todo_gui"
      }
    }
  })

  todo_gui.build(player, player_table)
end)

local function toggle_todo_gui(e)
  local player_table = global.players[e.player_index]
  local visible = player_table.todo.refs.window.visible
  if visible then
    todo_gui.close(e)
  else
    todo_gui.open(e)
  end
end

gui.hook_events(function(e)
  local action = gui.read_action(e)
  if action then
    if action == "toggle_todo_gui" then
      toggle_todo_gui(e)
    else
      todo_gui.actions[action](e)
    end
  end
end)
