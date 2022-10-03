extends Node

const DrinkOrder = preload("res://scripts/DrinkOrder.gd")
var Cup = load("res://scripts/Cup.gd")
const Ingredient = preload("res://scripts/Ingredient.gd")

var available_ingredients = Array()
var available_cup_sizes = Array()

func add_available_ingredient(ingredient: Ingredient):
    available_ingredients.append(ingredient.clone())

func add_available_cup_size(cup_size):
    available_cup_sizes.append(cup_size)

#generate drink order based off available machines
func generate_order(day, difficulty = 1):
    assert(available_ingredients.size() > 0)
    var order = DrinkOrder.new()

    var min_ingredients = difficulty + day / 5
    var max_ingredients = min_ingredients + difficulty * (day / 3) + 1

    print("min_ingredients: %d" % min_ingredients)
    print("max_ingredients: %d" % max_ingredients)

    var num_ingredients = rand_range(min_ingredients, max_ingredients)

    print("num_ingredients: %d" % num_ingredients)

    for i in num_ingredients:
        var ingredient = get_random_ingredient()
        print('adding %s' % ingredient)

        order.add_ingredient(ingredient, 1)

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
