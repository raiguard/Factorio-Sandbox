local pipe = data.raw["pipe"]["pipe"]

pipe.collision_box = {{-0.9, -0.9}, {0.9, 0.9}}
pipe.selection_box = {{-1, -1}, {1, 1}}
pipe.fluid_box.base_area = 4
pipe.fluid_box.pipe_connections = {
  {position = {-1.5, 0.01}},
  {position = {0.01, -1.5}},
  {position = {0.01, 1.5}},
  {position = {1.5, 0.01}}
}

for _, sprite in pairs(pipe.pictures) do
  sprite.scale = 2
  if sprite.hr_version then
    sprite.hr_version.scale = 1
  end
end

local underground_pipe = data.raw["pipe-to-ground"]["pipe-to-ground"]

underground_pipe.collision_box = {{-0.9, -0.9}, {0.9, 0.9}}
underground_pipe.selection_box = {{-1, -1}, {1, 1}}
underground_pipe.fluid_box.base_area = 4
underground_pipe.pipe_connections = {
  {position = {0.01, -1.5}},
  {position = {0, 1.5}, max_underground_distance = 30}
}

for _, sprite in pairs(underground_pipe.pictures) do
  sprite.scale = 2
  sprite.hr_version.scale = 1
end

for _, tbl in pairs(underground_pipe.fluid_box.pipe_covers) do
  for _, layer in pairs(tbl.layers) do
    layer.scale = 2
    layer.hr_version.scale = 1
  end
end
