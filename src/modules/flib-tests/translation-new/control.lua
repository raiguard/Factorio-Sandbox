local event = require("__flib__.event")
local translation = require("__flib__.translation-new")

local function build_strings()
  local profiler = game.create_profiler()
  local types = {
    "achievement",
    "ammo_category",
    "entity",
    "equipment_grid",
    "fluid",
    "fuel_category",
    "item",
    "module_category",
    "recipe",
    "recipe_category",
    "technology",
    "tile",
    "virtual_signal",
  }

  local dictionaries = {}

  for _, type in ipairs(types) do
    local descriptions = translation.new(type.."_description")
    local names = translation.new(type)
    for name, prototype in pairs(game[type.."_prototypes"]) do
      translation.add(descriptions, name, prototype.localised_description)
      translation.add(names, name, prototype.localised_name or name)
    end

    dictionaries[type.."_description"] = descriptions
    dictionaries[type] = names
  end

  global.dictionaries = dictionaries
  profiler.stop()
  log{"", "BUILD: ", profiler}
end

event.on_init(function()
  global.players = {}
  build_strings()
end)

event.on_player_created(function(e)
  local player = game.get_player(e.player_index)

  global.players[e.player_index] = {
    dictionaries = {}
  }

  local profiler = game.create_profiler()

  for _, dictionary in pairs(global.dictionaries) do
    player.request_translation(dictionary)
  end

  profiler.stop()
  log{"", "REQUEST: ", profiler}
end)

event.on_string_translated(function(e)
  local profiler = game.create_profiler()
  local dict_name, dictionary = translation.split_results(e)
  if dict_name and dictionary then
    global.players[e.player_index].dictionaries[dict_name] = dictionary
  end
  profiler.stop()
  log{"", "SEPARATE "..dict_name..": ", profiler}
end)

event.on_player_changed_position(function()
  local breakpoint
end)
