extends Node

const DrinkOrder = preload("res://scripts/DrinkOrder.gd")
var Cup = load("res://scripts/Cup.gd")
const Ingredient = preload("res://scripts/Ingredient.gd")

var available_ingredients = Array()

func add_available_ingredient(ingredient: Ingredient):
    available_ingredients.append(ingredient)

#generate drink order based off available machines
func generate_order():
    var order = DrinkOrder.new()

    #TODO: more order generation

    order.add_ingredient(available_ingredients[0])

    match randi() % 3:
        0: order.set_cup_size(Cup.CupSize.SMALL)
        1: order.set_cup_size(Cup.CupSize.MEDIUM)
        2: order.set_cup_size(Cup.CupSize.LARGE)

    # for i in range(rng.randi_range(difficulty, difficulty*3)):
    #         drinkOrder = addIngredient(ingredients[randi() % ingredients.size()],drinkOrder)

    return order
