data:extend({
  {
    type = "sprite",
    name = "se_cut",
    filename = "__base__/graphics/icons/shortcut-toolbar/mip/cut-x32.png",
    size = 32,
    mipmap_count = 2,
    flags = { "gui-icon" },
  },
  {
    type = "sprite",
    name = "se_scan",
    filename = "__Sandbox__/modules/universe-explorer/scan.png",
    size = 64,
    scale = 0.5,
    -- mipmap_count = 2,
    flags = { "gui-icon" },
  },
})

local styles = data.raw["gui-style"]["default"]

local empty_checkmark = {
  filename = "__space-exploration-graphics__/graphics/blank.png",
  priority = "very-low",
  width = 1,
  height = 1,
  frame_count = 1,
  scale = 8,
}

-- inactive is grey until hovered
-- checked = ascending, unchecked = descending
styles.se_sort_checkbox = {
  type = "checkbox_style",
  font = "default-bold",
  -- font_color = bold_font_color,
  padding = 0,
  default_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-white.png",
    size = { 16, 16 },
    scale = 0.5,
  },
  hovered_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-hover.png",
    size = { 16, 16 },
    scale = 0.5,
  },
  clicked_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-white.png",
    size = { 16, 16 },
    scale = 0.5,
  },
  disabled_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-white.png",
    size = { 16, 16 },
    scale = 0.5,
  },
  selected_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-white.png",
    size = { 16, 16 },
    scale = 0.5,
  },
  selected_hovered_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-hover.png",
    size = { 16, 16 },
    scale = 0.5,
  },
  selected_clicked_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-white.png",
    size = { 16, 16 },
    scale = 0.5,
  },
  selected_disabled_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-white.png",
    size = { 16, 16 },
    scale = 0.5,
  },
  checkmark = empty_checkmark,
  disabled_checkmark = empty_checkmark,
  text_padding = 5,
}

-- selected is orange by default
styles.se_selected_sort_checkbox = {
  type = "checkbox_style",
  parent = "se_sort_checkbox",
  default_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-down-active.png",
    size = { 16, 16 },
    scale = 0.5,
  },
  selected_graphical_set = {
    filename = "__core__/graphics/arrows/table-header-sort-arrow-up-active.png",
    size = { 16, 16 },
    scale = 0.5,
  },
}

styles.se_universe_list_item = {
  type = "button_style",
  parent = "list_box_item",
  disabled_font_color = button_hovered_font_color,
  disabled_graphical_set = {
    base = { position = { 225, 17 }, corner_size = 8 },
    shadow = default_dirt,
  },
}

styles.se_universe_list_scroll_pane = {
  type = "scroll_pane_style",
  parent = "list_box_scroll_pane",
  graphical_set = {
    shadow = default_inner_shadow,
  },
  vertical_flow_style = {
    type = "vertical_flow_style",
    vertical_spacing = 0,
  },
}
