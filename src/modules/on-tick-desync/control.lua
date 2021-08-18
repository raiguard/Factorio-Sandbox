-- This script demonstrates a desync with this method of self-deregistration.
-- Start a new freeplay game with this, then load the autosave it creates. The on_tick event will not be re-registered
-- on save even though it should be.

local event = require("__flib__.event")

local function on_tick(e)
  local deregister = true

  if global.do_something then
    deregister = false
    global.do_something = false
    game.auto_save("desync")
  end

  if deregister then
    log("DEREGISTERING")
    event.on_tick(nil)
  end
end

local function register_on_tick()
  if global.do_something then
    log("REGISTERING!")
    event.on_tick(on_tick)
  else
    log("NOT REGISTERING!")
  end
end

event.on_init(function()
  global.do_something = true
  register_on_tick()
end)

event.on_load(function()
  register_on_tick()
end)
