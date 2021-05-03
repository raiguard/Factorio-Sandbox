local test = table.deepcopy(data.raw["recipe"]["advanced-oil-processing"])
test.name = "test-recipe"
test.ingredients[2].maximum_temperature = 421
test.ingredients[3] = {
  type = "fluid",
  name = "petroleum-gas",
  amount = 750,
  minimum_temperature = 100,
  maximum_temperature = 420.13289473205359
}
test.ingredients[4] = {
  type = "fluid",
  name = "lubricant",
  amount = 69,
  minimum_temperature = 100
}
test.ingredients[5] = {
  type = "fluid",
  name = "sulfuric-acid",
  amount = 420,
  temperature = 100
}

data.raw["fluid"]["petroleum-gas"].max_temperature = 150
test.results[1] = {
  type = "fluid",
  name = "petroleum-gas",
  amount = 55,
  temperature = 100,
}
data.raw["fluid"]["heavy-oil"].max_temperature = 1000000
test.results[2] = {
  type = "fluid",
  name = "heavy-oil",
  amount = 25,
  temperature = 1000000
}
data.raw["fluid"]["light-oil"].default_temperature = -50
data.raw["fluid"]["light-oil"].max_temperature = 50
test.results[3] = {
  type = "fluid",
  name = "light-oil",
  amount = 45,
  temperature = 0
}

data:extend{test}

