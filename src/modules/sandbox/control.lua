local event = require("__flib__.event")

event.on_init(function()
  global.count = 0
end)

event.on_equipment_inserted(function(e)
  global.count = global.count + 1
  game.print(global.count.." INSERTED "..e.equipment.name)
end)

event.on_equipment_removed(function(e)
  global.count = global.count + 1
  game.print(global.count.." REMOVED "..e.equipment)
end)