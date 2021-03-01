local flib_position = {}

function flib_position.negate(position)
  position.x = -position.x
  position.y = -position.y

  return position
end

function flib_position.load(area)
  return setmetatable(area, {
    __index = flib_position,
    __unm = flib_position.negate
  })
end

return flib_position
