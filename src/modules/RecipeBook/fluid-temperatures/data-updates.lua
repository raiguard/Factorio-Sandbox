local test = table.deepcopy(data.raw["recipe"]["advanced-oil-processing"])
test.name = "test-recipe"
test.ingredients[1].temperature = 500
test.ingredients[2].maximum_temperature = 421
test.ingredients[3] = {
  type = "fluid",
  name = "petroleum-gas",
  amount = 750,
  minimum_temperature = 100,
  maximum_temperature = 420.13289473205359
}

data:extend{test}

