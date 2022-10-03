extends Node

var Cup = load("res://scripts/Cup.gd")
const Ingredient = preload("res://scripts/Ingredient.gd")
const IngredientList = preload("res://scripts/IngredientList.gd")

var cup_size = Cup.CupSize.MEDIUM
var ingredients = IngredientList.new()

func add_ingredient(ingredient : Ingredient, count = 1):
    ingredients.add_ingredient(ingredient, count)

func get_ingredients():
    return ingredients.get_ingredients()

func has_ingredient(ingredient):
    return ingredients.has_ingredient(ingredient)

func set_cup_size(size):
    cup_size = size

func get_cup_size():
    return cup_size

func is_fulfilled_by(cup):
    if cup.size != cup_size:
        print('wrong cup size')
        return false

    return cup.ingredients.equals(ingredients)

func _to_string():
    return '[DrinkOrder ingredients=%s cup_size=%s]' % [ingredients, cup_size]
