local event = require("__flib__.event")
local gui = require("__flib__.gui")

local hovered_font_color = { 28, 28, 28 }

local function sort_checkbox(caption, width, center)
  if center == nil then
    center = true
  end
  return {
    type = "flow",
    style_mods = { width = width, horizontal_align = center and "center" or nil },
    {
      type = "checkbox",
      style = "se_selected_sort_checkbox",
      state = false,
      caption = caption,
    },
  }
end

local function list_row(hierarchy, icon, name, radius, ore, attrition, threat, solar, flags, priority, selected)
  local font_color = selected and hovered_font_color or nil

  return {
    type = "button",
    style = "se_universe_list_item",
    style_mods = { horizontally_stretchable = true, left_padding = 4, right_padding = 4 },
    enabled = not selected,
    {
      type = "flow",
      style_mods = { padding = 0, margin = 0 },
      ignored_by_interaction = true,
      { type = "label", style_mods = { font_color = font_color, width = 68 }, caption = hierarchy },
      {
        type = "label",
        style_mods = { font_color = font_color, width = 68, horizontal_align = "center" },
        caption = icon,
      },
      { type = "label", style_mods = { font_color = font_color, width = 210 }, caption = name },
      {
        type = "label",
        style_mods = { font_color = font_color, width = 68, horizontal_align = "center" },
        caption = radius,
      },
      {
        type = "label",
        style_mods = { font_color = font_color, width = 68, horizontal_align = "center" },
        caption = ore,
      },
      {
        type = "label",
        style_mods = { font_color = font_color, width = 68, horizontal_align = "center" },
        caption = attrition,
      },
      {
        type = "label",
        style_mods = { font_color = font_color, width = 68, horizontal_align = "center" },
        caption = threat,
      },
      {
        type = "label",
        style_mods = { font_color = font_color, width = 68, horizontal_align = "center" },
        caption = solar,
      },
      {
        type = "label",
        style_mods = { font_color = font_color, width = 68, horizontal_align = "center" },
        caption = flags,
      },
      {
        type = "label",
        style_mods = { font_color = font_color, width = 68, horizontal_align = "center" },
        caption = priority,
      },
    },
  }
end

local function detail_flow(label, value)
  return {
    type = "flow",
    { type = "label", style_mods = { font = "default-semibold" }, caption = label },
    { type = "empty-widget", style = "flib_horizontal_pusher" },
    { type = "label", caption = value },
  }
end

local function resource_bar(resource_name)
  local resource = game.entity_prototypes[resource_name]
  return {
    type = "flow",
    style_mods = { top_padding = 2, bottom_padding = 2 },
    { type = "label", style_mods = { top_margin = 4 }, caption = "[img=entity/" .. resource_name .. "]" },
    {
      type = "progressbar",
      style_mods = {
        bar_width = 24,
        color = resource.map_color,
        font = "default-semibold",
        font_color = resource_name == "coal" and { 255, 255, 255 } or { 28, 28, 28 },
        horizontally_stretchable = true,
        top_padding = 1,
      },
      caption = resource.localised_name,
      value = 1,
    },
  }
end

local function priority_display()
  return { type = "label", caption = "[img=virtual-signal/se-accolade]" }, {
    type = "textfield",
    style_mods = { width = 50, horizontal_align = "center" },
    text = "1",
  }, {
    type = "flow",
    style_mods = { vertical_spacing = 0, top_margin = 2 },
    direction = "vertical",
    {
      type = "sprite-button",
      style = "mini_button_aligned_to_text_vertically",
      style_mods = { padding = -1, margin = 0, height = 14, width = 14 },
      sprite = "rb_collapsed",
    },
    {
      type = "sprite-button",
      style = "mini_button_aligned_to_text_vertically",
      style_mods = { padding = -1, margin = 0, height = 14, width = 14 },
      sprite = "rb_expanded",
    },
  }
end

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
          sprite = "utility/close_white",
          hovered_sprite = "utility/close_black",
          clicked_sprite = "utility/close_black",
          tooltip = { "gui.close-instruction" },
        },
      },
      {
        type = "flow",
        style_mods = { height = 745, horizontal_spacing = 12 },
        {
          type = "frame",
          style = "inside_deep_frame",
          direction = "vertical",
          {
            type = "frame",
            style = "subheader_frame",
            style_mods = { left_padding = 8, right_padding = 8 },
            sort_checkbox("[img=virtual-signal/se-hierarchy]", 68),
            sort_checkbox("[img=virtual-signal/se-planet]", 68),
            sort_checkbox("Name", 210, false),
            sort_checkbox("[img=virtual-signal/se-radius]", 68),
            sort_checkbox("[img=item/se-core-fragment-omni]", 68),
            sort_checkbox("[img=item/logistic-robot]", 68),
            sort_checkbox("[img=item/artillery-targeting-remote]", 68),
            sort_checkbox("[img=item/solar-panel]", 68),
            sort_checkbox("[img=item/se-rocket-landing-pad]", 68),
            sort_checkbox("[img=virtual-signal/se-accolade]", 68),
          },
          {
            type = "scroll-pane",
            style = "se_universe_list_scroll_pane",
            style_mods = { horizontally_stretchable = true, vertically_stretchable = true, height = 28 * 24 },
            list_row("⬤", "[img=virtual-signal/se-star]", "Calidus Orbit", "-", "-", "10.23", "0%", "1526%", "", "0"),
            list_row(
              "   | - ●",
              "[img=virtual-signal/se-planet]",
              "Nauvis",
              "5692",
              "[img=item/se-core-fragment-omni]",
              "1.00",
              "33%",
              "100%",
              "",
              "1",
              true
            ),
            list_row(
              "   |    ○",
              "[img=virtual-signal/se-planet-orbit]",
              "Nauvis Orbit",
              "-",
              "-",
              "7.31",
              "0%",
              "467%",
              "",
              "0"
            ),
            list_row(
              "   | - ●",
              "[img=virtual-signal/se-planet]",
              "Cinrad",
              "6391",
              "[img=item/iron-ore]",
              "0.79",
              "7%",
              "83%",
              "",
              "0"
            ),
            list_row(
              "   |    ○",
              "[img=virtual-signal/se-planet-orbit]",
              "Cinrad Orbit",
              "-",
              "-",
              "6.71",
              "0%",
              "417%",
              "",
              "0"
            ),
            list_row(
              "   | - ●",
              "[img=virtual-signal/se-planet]",
              "Kuyou",
              "4029",
              "[img=item/uranium-ore]",
              "0.40",
              "67%",
              "33%",
              "",
              "0"
            ),
            list_row(
              "   |    ○",
              "[img=virtual-signal/se-planet-orbit]",
              "Kuyou Orbit",
              "-",
              "-",
              "3.12",
              "0%",
              "167%",
              "",
              "0"
            ),
            list_row(
              " ✖",
              "[img=virtual-signal/se-asteroid-field]",
              "Cosmic Dustlands",
              "-",
              "[img=item/se-methane-ice]",
              "0.10",
              "0%",
              "1%",
              "",
              "0"
            ),
          },
          {
            type = "frame",
            style = "subfooter_frame",
            {
              type = "flow",
              style_mods = { horizontal_spacing = 0 },
              { type = "sprite-button", style = "flib_selected_tool_button", sprite = "virtual-signal/se-star" },
              { type = "sprite-button", style = "flib_selected_tool_button", sprite = "virtual-signal/se-planet" },
              {
                type = "sprite-button",
                style = "flib_selected_tool_button",
                sprite = "virtual-signal/se-planet-orbit",
              },
              { type = "sprite-button", style = "flib_selected_tool_button", sprite = "virtual-signal/se-moon" },
              {
                type = "sprite-button",
                style = "flib_selected_tool_button",
                sprite = "virtual-signal/se-moon-orbit",
              },
              {
                type = "sprite-button",
                style = "flib_selected_tool_button",
                sprite = "virtual-signal/se-asteroid-belt",
              },
              {
                type = "sprite-button",
                style = "flib_selected_tool_button",
                sprite = "virtual-signal/se-asteroid-field",
              },
              {
                type = "sprite-button",
                style = "flib_selected_tool_button",
                sprite = "virtual-signal/se-spaceship",
              },
            },
            { type = "empty-widget", style = "flib_horizontal_pusher" },
            { type = "flow", style_mods = { vertical_align = "center", top_margin = -2 }, priority_display() },
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
              { type = "label", style = "subheader_caption_label", caption = "Nauvis" },
              { type = "empty-widget", style = "flib_horizontal_pusher" },
              priority_display(),
            },
            {
              type = "scroll-pane",
              style = "flib_naked_scroll_pane",
              direction = "vertical",
              detail_flow("Zone type", "[img=virtual-signal/se-planet]  Planet"),
              detail_flow("Parent", "Calidus"),
              detail_flow("Radius", "5692"),
              detail_flow("Day/night cycle", "6.94 minutes"),
              detail_flow("Robot interference wind", "1.00"),
              detail_flow("Threat", "33%"),
              detail_flow("Solar", "100%"),
              detail_flow("Automation signal", "[img=virtual-signal/se-planet]  4"),
              { type = "line", direction = "horizontal" },
              resource_bar("crude-oil"),
              resource_bar("iron-ore"),
              resource_bar("stone"),
              resource_bar("copper-ore"),
              resource_bar("coal"),
              resource_bar("uranium-ore"),
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
