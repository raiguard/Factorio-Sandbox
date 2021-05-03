local offshore_pump_recipe = data.raw["recipe"]["offshore-pump"]

offshore_pump_recipe.enabled = false

local tech = data.raw["technology"]["advanced-material-processing"]
tech.effects[#tech.effects + 1] = {type = "unlock-recipe", recipe = "offshore-pump"}
