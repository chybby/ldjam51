extends CenterContainer

@onready var count = $HBoxContainer/Count
@onready var ingredient : TextureRect = $HBoxContainer/Container/Ingredient
@onready var ingredient_modifier : TextureRect = $HBoxContainer/Container/Modifier


func set_count(new_count):
    count.text = str(new_count)


func set_ingredient(new_ingredient):
    ingredient.texture = load(new_ingredient.icon_file_name())

    ingredient_modifier.visible = true

    if new_ingredient.frothed:
        ingredient_modifier.texture = load('res://assets/frothed.png')
    elif new_ingredient.blended:
        ingredient_modifier.texture = load('res://assets/blended.png')
    else:
        ingredient_modifier.visible = false
