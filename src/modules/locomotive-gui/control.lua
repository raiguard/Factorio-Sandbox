local event = require("__flib__.event")
local gui = require("__flib__.gui-beta")

local function create_gui(player, entity)
  local character_slots = {}
  for i = 1, 140 do
    character_slots[i] = {type = "sprite-button", style = "slot"}
  end

  local refs = gui.build(player.gui.screen, {
    {type = "frame", direction = "vertical", ref = {"window"}, children = {
      {type = "flow", style = "flib_titlebar_flow", children = {
        {type = "label", style = "frame_title", caption = "Locomotive"},
        {type = "empty-widget", style = "flib_titlebar_drag_handle", ref = {"drag_handle"}},
        {
          type = "sprite-button",
          style = "frame_action_button",
          sprite = "utility/close_white"
        }
      }},
      {type = "flow", style_mods = {horizontal_spacing = 12}, children = {
        {type = "frame", style = "inside_shallow_frame", children = {
          {type = "scroll-pane", style = "character_inventory_scroll_pane", direction = "vertical", children = {
            {type = "label", style = "inventory_label", caption = "Character"},
            {type = "table", style = "slot_table", column_count = 10, children = character_slots}
          }}
        }},
        {type = "frame", style = "inside_shallow_frame", direction = "vertical", children = {
          {type = "frame", style = "subheader_frame", children = {
            {type = "empty-widget", style = "flib_horizontal_pusher"},
            {type = "sprite-button", style = "tool_button", sprite = "utility/color_picker"},
            {type = "empty-widget", style = "color_indicator"}
          }},
          {
            type = "flow",
            style = "vertical_flow_in_entity_frame_without_side_paddings",
            style_mods = {top_margin = 6},
            direction = "vertical",
            children = {
              {type = "flow", style = "flib_indicator_flow", children = {
                {type = "sprite", style = "flib_indicator", sprite = "flib_indicator_green"},
                {type = "label", caption = "On the path"}
              }},
              {type = "frame", style = "deep_frame_in_shallow_frame", children = {
                {type = "entity-preview", style = "wide_entity_button", elem_mods = {entity = entity}}
              }},
              {type = "flow", style = "player_input_horizontal_flow", style_mods = {top_margin = 4}, children = {
                {type = "sprite-button", style = "slot", sprite = "utility/slot_icon_fuel"},
                {type = "progressbar", style_mods = {horizontally_stretchable = true}},
                {type = "sprite-button", style = "slot"}
              }},
              {type = "empty-widget", style = "vertical_lines_slots_filler"}
            }
          }
        }}
      }}
    }}
  })

  refs.window.force_auto_center()
  refs.drag_handle.drag_target = refs.window
end

event.on_selected_entity_changed(function(e)
  local player = game.get_player(e.player_index)

  local selected = player.selected
  if selected and selected.valid and selected.type == "locomotive" then
    create_gui(player, selected)
  end
end)
