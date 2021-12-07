local event = require("__flib__.event")
local table = require("__flib__.table")

event.on_player_created(function(e)
  local arr = {1, 2, 3, 4, 5}
  local slice  = table.slice(arr, 3, 0)

  game.print(serpent.line{arr, slice})
end)
