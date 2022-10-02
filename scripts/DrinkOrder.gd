extends Node

var Cup = load("res://scripts/Cup.gd")
const Ingredient = preload("res://scripts/Ingredient.gd")
const IngredientList = preload("res://scripts/IngredientList.gd")

var cup_size = Cup.CupSize.MEDIUM
var ingredients = IngredientList.new()

func add_ingredient(ingredient : Ingredient):
    ingredients.add_ingredient(ingredient)

func set_cup_size(size):
    cup_size = size

func is_fulfilled_by(cup):
    if cup.size != cup_size:
        print('wrong cup size')
        return false

    return cup.ingredients.equals(ingredients)

func _to_string():
    return '[DrinkOrder ingredients=%s cup_size=%s]' % [ingredients, cup_size]