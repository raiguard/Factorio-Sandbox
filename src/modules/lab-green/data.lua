local green = table.deepcopy(data.raw["tile"]["lab-white"])
green.name = "lab-green"
green.variants.main[1].picture = "__Sandbox__/modules/lab-green/lab-green.png"

data:extend{green}
