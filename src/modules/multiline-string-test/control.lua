script.on_event(defines.events.on_player_created, function(e)
  local player = game.get_player(e.player_index)

  local frame = player.gui.screen.add({ type = "frame", name = "string_test_frame", caption = "String test" })
  local content_frame = frame.add({ type = "frame", name = "content_frame", style = "inside_shallow_frame" })
  local scroll_pane = content_frame.add({ type = "scroll-pane", name = "scroll_pane" })
  scroll_pane.style.width = 300
  scroll_pane.style.maximal_height = 500
  scroll_pane.style.padding = 12
  local first_flow = scroll_pane.add({ type = "flow", name = "first_flow" })
  first_flow.add({ type = "label", caption = "Left", ignored_by_interaction = true })
  first_flow.add({ type = "empty-widget" }).style.horizontally_stretchable = true
  first_flow.add({ type = "label", caption = "right", ignored_by_interaction = true })
  local flow = scroll_pane.add({ type = "flow", name = "flow", visible = false })
  local text = flow.add({
    type = "label",
    caption = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
  })
  text.style.horizontally_squashable = true
  text.style.single_line = false
end)

script.on_event(defines.events.on_gui_click, function(e)
  if e.element and e.element.valid and e.element.name == "first_flow" then
    e.element.parent.flow.visible = not e.element.parent.flow.visible
  end
end)
