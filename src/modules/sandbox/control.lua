script.on_event(defines.events.on_string_translated, function(e)
  if not e.translated then
    log(serpent.line(e.localised_string))
  end
end)

script.on_event(defines.events.on_player_created, function(e)
  local player = game.get_player(e.player_index)
  for _, tech in pairs(game.technology_prototypes) do
    player.request_translation(tech.localised_description)
  end
end)