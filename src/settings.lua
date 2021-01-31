local modules = require("modules")
for _, module in pairs(modules) do
  local status, err = pcall(require, "modules."..module..".settings")
  if not status and not string.find(err, "no such file") then
    error(err)
  end
end