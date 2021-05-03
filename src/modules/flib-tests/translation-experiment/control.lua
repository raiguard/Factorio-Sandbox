local event = require("__flib__.event")

local inner_separator = "⤬"
local separator = "⤬⤬⤬"

event.on_init(function()
  global.players = {}

  local strings = {}

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

  for _, type in ipairs(types) do
    local output = {"", "FLIB_TRANSLATION_DICTIONARY", inner_separator, type, separator}
    local ref = output

    local function add(key, value)
      local obj = {"", key, inner_separator, value, separator}
      ref[6] = obj
      ref = obj
    end

    for name, prototype in pairs(game[type.."_prototypes"]) do
      add(name, prototype.localised_name or name)
      add(name.."@description", prototype.localised_description)
    end

    strings[type] = output
  end

  global.strings = strings
end)

event.on_player_created(function(e)
  local player = game.get_player(e.player_index)

  global.players[e.player_index] = {}

  if global.strings then
    for _, tbl in pairs(global.strings) do
      player.request_translation(tbl)
    end
  end
end)

event.on_string_translated(function(e)
  if e.translated then
    local dictionary = {}
    local _, _, dict_name, translation = string.find(
      e.result,
      "FLIB_TRANSLATION_DICTIONARY"..inner_separator.."(.-)"..separator.."(.*)$"
    )
    if dict_name and translation then
      for str in string.gmatch(e.result, "(.-)"..separator) do
        local _, _, key, value = string.find(str, "^(.-)"..inner_separator.."(.-)$")
        if key then
          dictionary[key] = value
        end
      end
      dictionary["FLIB_TRANSLATION_DICTIONARY"] = nil

      global.players[e.player_index][dict_name] = dictionary
    end
  end
end)

event.on_player_changed_position(function()
  local breakpoint
end)
