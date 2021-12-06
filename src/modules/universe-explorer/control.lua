local event = require("__flib__.event")
local gui = require("__flib__.gui")

event.on_player_created(function(e)
  local player = game.get_player(e.player_index)

  local refs = gui.build(player.gui.screen, {
    {
      type = "frame",
      direction = "vertical",
      ref = { "window" },
      {
        type = "flow",
        style = "flib_titlebar_flow",
        ref = { "titlebar_flow" },
        {
          type = "label",
          style = "frame_title",
          caption = "Universe",
          ignored_by_interaction = true,
        },
        { type = "empty-widget", style = "flib_titlebar_drag_handle", ignored_by_interaction = true },
        {
          type = "button",
          style = "frame_button",
          style_mods = { height = 24, font_color = { 255, 255, 255 }, left_padding = 4, right_padding = 4 },
          caption = "[img=se-map-gui-starmap]  Interstellar Map",
        },
        { type = "line", style_mods = { top_margin = -2, bottom_margin = 2 }, direction = "vertical" },
        {
          type = "sprite-button",
          style = "frame_action_button",
          sprite = "utility/search_white",
          hovered_sprite = "utility/search_black",
          clicked_sprite = "utility/search_black",
          tooltip = { "gui.search" },
        },
        {
          type = "sprite-button",
          style = "frame_action_button",
          sprite = "flib_pin_white",
          hovered_sprite = "flib_pin_black",
          clicked_sprite = "flib_pin_black",
          tooltip = "Keep open",
        },
        {
          type = "sprite-button",
          style = "frame_action_button",
          sprite = "utility/close_white",
          hovered_sprite = "utility/close_black",
          clicked_sprite = "utility/close_black",
          tooltip = { "gui.close-instruction" },
        },
      },
      {
        type = "flow",
        style_mods = { horizontal_spacing = 12 },
        {
          type = "frame",
          style = "inside_deep_frame",
          style_mods = { width = 800, height = 700 },
          direction = "vertical",

          {
            type = "frame",
            style = "subheader_frame",
            style_mods = { horizontally_stretchable = true },
            { type = "label", style = "subheader_caption_label", caption = "List" },
          },
          {
            type = "scroll-pane",
            style = "list_box_scroll_pane",
            style_mods = { horizontally_stretchable = true, vertically_stretchable = true },
          },
        },
        {
          type = "flow",
          style_mods = { vertical_spacing = 12 },
          direction = "vertical",
          {
            type = "frame",
            style = "inside_shallow_frame",
            style_mods = { width = 300, vertically_stretchable = true },
            direction = "vertical",

            {
              type = "frame",
              style = "subheader_frame",
              style_mods = { horizontally_stretchable = true },
              { type = "label", style = "subheader_caption_label", caption = "Surface info" },
            },
          },
          {
            type = "frame",
            style = "inside_deep_frame",
            {
              type = "camera",
              style_mods = { height = 300, width = 300 },
              position = { x = 0, y = 0 },
              surface_index = 1,
              zoom = 0.2,
            },
          },
        },
      },
      {
        type = "flow",
        style = "dialog_buttons_horizontal_flow",
        ref = { "footer_flow" },
        {
          type = "empty-widget",
          style = "flib_dialog_footer_drag_handle",
          style_mods = { left_margin = 0 },
          ignored_by_interaction = true,
        },
        { type = "button", style = "confirm_button", caption = "View surface", ref = { "view_surface_button" } },
      },
    },
  })

  refs.window.force_auto_center()
  refs.titlebar_flow.drag_target = refs.window
end)
