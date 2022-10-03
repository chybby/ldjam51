extends Node

const DrinkOrder = preload("res://scripts/DrinkOrder.gd")
var Cup = load("res://scripts/Cup.gd")
const Ingredient = preload("res://scripts/Ingredient.gd")

var available_ingredients = Array()
var available_cup_sizes = Array()

func add_available_ingredient(ingredient: Ingredient):
    available_ingredients.append(ingredient)

func add_available_cup_size(cup_size):
    available_cup_sizes.append(cup_size)

#generate drink order based off available machines
func generate_order():
    assert(available_ingredients.size() > 0)
    var order = DrinkOrder.new()

    #TODO: more order generation

    var min_ingredients = 1
    var max_ingredients = 5
    var min_count = 1
    var max_count = 5

    var num_ingredients = rand_range(min_ingredients, max_ingredients)

    for i in num_ingredients:
        var ingredient = get_random_ingredient()
        var count = rand_range(min_count, max_count)

        if order.has_ingredient(ingredient):
            continue

        order.add_ingredient(ingredient, count)

    order.set_cup_size(available_cup_sizes[randi() % available_cup_sizes.size()])

    # for i in range(rng.randi_range(difficulty, difficulty*3)):
    #         drinkOrder = addIngredient(ingredients[randi() % ingredients.size()],drinkOrder)

    print("generated order %s" % order)

    return order

func get_random_ingredient():
    var ingredient = available_ingredients[randi() % available_ingredients.size()]
    if ingredient.is_blendable:
        ingredient.blended = (randi() % 2) == 1

    if ingredient.is_frothable:
        ingredient.frothed = (randi() % 2) == 1

    return ingredient

func rand_range(minimum, maximum):
    return minimum + (randi() % (maximum - minimum + 1))
