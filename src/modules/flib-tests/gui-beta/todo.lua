local gui = require("__flib__.gui-beta")
local table = require("__flib__.table")

local todo_gui = {}

local view_modes = table.invert{
  "all",
  "active",
  "completed"
}

local function update_mode_radios(gui_data)
  local mode = gui_data.state.mode
  local subfooter_flow = gui_data.refs.subfooter_flow

  subfooter_flow.all_radiobutton.state = mode == view_modes.all
  subfooter_flow.active_radiobutton.state = mode == view_modes.active
  subfooter_flow.completed_radiobutton.state = mode == view_modes.completed
end

local function update_todos(gui_data)
  local state = gui_data.state
  local refs = gui_data.refs

  local todos_flow = refs.todos_flow
  local children = todos_flow.children
  local i = 0
  local active_count = 0
  local completed_count = 0
  for id, todo in pairs(gui_data.state.todos) do
    if todo.completed then
      completed_count = completed_count + 1
    else
      active_count = active_count + 1
    end

    if
      state.mode == view_modes.all
      or (state.mode == view_modes.active and not todo.completed)
      or (state.mode == view_modes.completed and todo.completed)
    then
      i = i + 1
      local child = children[i]
      if child then
        -- update
        child.checkbox.state = todo.completed
        child.checkbox.caption = todo.text

        -- TODO create helper function for this
        local tags = child.checkbox.tags
        tags.todo_id = id
        child.checkbox.tags = tags
        tags = child.delete_button.tags
        tags.todo_id = id
        child.delete_button.tags = tags
      else
        -- build
        gui.build(todos_flow, {
          {type = "flow", style_mods = {vertical_align = "center"}, children = {
            {
              type = "checkbox",
              name = "checkbox",
              caption = todo.text,
              state = todo.completed,
              handlers = {
                on_click = "todo_toggle_completed"
              },
              tags = {todo_id = id}
            },
            {type = "empty-widget", style = "flib_horizontal_pusher"},
            {
              type = "sprite-button",
              name = "delete_button",
              style = "tool_button_red",
              sprite = "utility/trash",
              tooltip = "Delete",
              handlers = {
                on_click = "todo_delete_todo"
              },
              tags = {todo_id = id}
            }
          }}
        })
      end
    end
  end
  for j = i + 1, #children do
    children[j].destroy()
  end

  if i == 0 then
    todos_flow.visible = false
  else
    todos_flow.visible = true
  end

  refs.subfooter_flow.items_left_label.caption = active_count.." items left"
  refs.subfooter_flow.clear_completed_button.enabled = completed_count > 0
end

function todo_gui.build(player, player_table)
  local refs = gui.build(player.gui.screen, {
    {
      type = "frame",
      direction = "vertical",
      ref = {"window"},
      handlers = {
        on_closed = "todo_close"
      },
      children = {
        {type = "flow", ref = {"titlebar_flow"}, children = {
          {type ="label", style = "frame_title", caption = "TodoMVC", ignored_by_interaction = true},
          {type = "empty-widget", style = "flib_titlebar_drag_handle", ignored_by_interaction = true},
          {
            type = "sprite-button",
            style = "frame_action_button",
            sprite = "utility/close_white",
            hovered_sprite = "utility/close_black",
            clicked_sprite = "utility/close_black",
            mouse_button_filter = {"left"},
            handlers = {
              on_click = "todo_close"
            }
          }
        }},
        {type = "frame", style = "inside_shallow_frame", direction = "vertical", children = {
          {
            type = "textfield",
            style_mods = {width = 500, margin = 12},
            ref = {"textfield"},
            handlers = {
              on_confirmed = "todo_add_todo"
            }
          },
          {
            type = "flow",
            style_mods = {left_margin = 12, right_margin = 12, bottom_margin = 12},
            direction = "vertical",
            elem_mods = {visible = false},
            ref = {"todos_flow"}
          },
          {type = "frame", style = "subfooter_frame", children = {
            {
              type = "flow",
              style_mods = {vertical_align = "center", left_margin = 8},
              ref = {"subfooter_flow"},
              children = {
                {type = "label", name = "items_left_label", caption = "0 items left"},
                {type = "empty-widget", style = "flib_horizontal_pusher"},
                {
                  type = "radiobutton",
                  name = "all_radiobutton",
                  caption = "All",
                  state = true,
                  handlers = {
                    on_checked_state_changed = "todo_change_mode"
                  },
                  tags = {mode = view_modes.all}
                },
                {
                  type = "radiobutton",
                  name = "active_radiobutton",
                  caption = "Active",
                  state = false,
                  handlers = {
                    on_checked_state_changed = "todo_change_mode"
                  },
                  tags = {mode = view_modes.active}
                },
                {
                  type = "radiobutton",
                  name = "completed_radiobutton",
                  caption = "Completed",
                  state = false,
                  handlers = {
                    on_checked_state_changed = "todo_change_mode"
                  },
                  tags = {mode = view_modes.completed}
                },
                {type = "empty-widget", style = "flib_horizontal_pusher"},
                {
                  type = "button",
                  name = "clear_completed_button",
                  caption = "Clear completed",
                  elem_mods = {enabled = false},
                  handlers = {
                    on_click = "todo_delete_completed_todos"
                  }
                }
              }
            }
          }}
        }}
      }
    }
  })

  refs.titlebar_flow.drag_target = refs.window
  refs.window.force_auto_center()

  player_table.todo = {
    state = {
      mode = view_modes.all,
      next_id = 1,
      todos = {},
      visible = false
    },
    refs = refs
  }
end

function todo_gui.open(e)
  local player = game.get_player(e.player_index)
  local player_table = global.players[e.player_index]
  local gui_data = player_table.todo

  gui_data.refs.window.visible = true
  player.opened = gui_data.refs.window
end

function todo_gui.close(e)
  local player = game.get_player(e.player_index)
  local player_table = global.players[e.player_index]
  local gui_data = player_table.todo

  gui_data.refs.window.visible = false
  if player.opened then
    player.opened = nil
  end
end

local function add_todo(e)
  local player_table = global.players[e.player_index]
  local gui_data = player_table.todo
  local state = gui_data.state

  local todo_text = e.element.text

  state.todos[state.next_id] = {
    completed = false,
    text = todo_text
  }

  state.next_id = state.next_id + 1

  e.element.text = ""

  update_todos(gui_data)
end

local function toggle_todo_completed(e)
  local player_table = global.players[e.player_index]
  local gui_data = player_table.todo
  local state = gui_data.state

  local todo_data = state.todos[e.element.tags.todo_id]
  todo_data.completed = e.element.state

  update_todos(gui_data)
end

local function delete_todo(e)
  local player_table = global.players[e.player_index]
  local gui_data = player_table.todo
  local state = gui_data.state

  state.todos[e.element.tags.todo_id] = nil

  update_todos(gui_data)
end

local function delete_completed_todos(e)
  local player_table = global.players[e.player_index]
  local gui_data = player_table.todo
  local state = gui_data.state

  for id, todo in pairs(state.todos) do
    if todo.completed then
      state.todos[id] = nil
    end
  end

  update_todos(gui_data)
end

local function change_view_mode(e)
  local player_table = global.players[e.player_index]
  local gui_data = player_table.todo
  local state = gui_data.state

  state.mode = e.element.tags.mode

  update_mode_radios(gui_data)
  update_todos(gui_data)
end

todo_gui.handlers = {
  todo_close = todo_gui.close,
  todo_add_todo = add_todo,
  todo_toggle_completed = toggle_todo_completed,
  todo_delete_todo = delete_todo,
  todo_delete_completed_todos = delete_completed_todos,
  todo_change_mode = change_view_mode
}

return todo_gui