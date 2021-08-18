local event = require("__flib__.event")
local dictionary = require("__flib__.dictionary")
local migration = require("__flib__.migration")

local function create_demo_dictionaries()
  for _, type in pairs{"entity", "fluid", "item", "recipe", "technology", "tile"} do
    local Names = dictionary.new(type.."_names", true)
    local Descriptions = dictionary.new(type.."_descriptions")
    for name, prototype in pairs(game[type.."_prototypes"]) do
      Names:add(name, prototype.localised_name, true)
      Descriptions:add(name, prototype.localised_description)
    end
  end

  local Demo = dictionary.new("demo", true)
  for i = 1, 100000 do
    Demo:add(i, "THE NUMBER "..i)
  end
end

event.on_init(function()
  dictionary.init()

  global.player_dictionaries = {}
  create_demo_dictionaries()
end)

event.on_configuration_changed(function(e)
  if migration.on_config_changed(e, {}) then
    dictionary.init()
    create_demo_dictionaries()
  end
end)

event.on_player_created(function(e)
  local player = game.get_player(e.player_index)
  if player.connected then
    dictionary.translate(player)
  end
end)

event.on_player_joined_game(function(e)
  dictionary.translate(game.get_player(e.player_index))
end)

event.on_player_left_game(function(e)
  dictionary.cancel_translation(e.player_index)
end)

event.on_tick(dictionary.check_skipped)

event.on_string_translated(dictionary.process_translation)

event.register(dictionary.on_language_translated, function(e)
  for _, player_index in pairs(e.players) do
    global.player_dictionaries[player_index] = e.dictionaries
  end
  -- __DebugAdapter.breakpoint()
  game.print("DONE!")
end)
