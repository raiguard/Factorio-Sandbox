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

data:extend{test}

