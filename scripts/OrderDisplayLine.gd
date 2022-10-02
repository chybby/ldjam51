extends CenterContainer

@onready var count = $HBoxContainer/Count
@onready var ingredient = $HBoxContainer/Container/Ingredient
@onready var ingredient_modifier = $HBoxContainer/Container/Modifier


func set_count(new_count):
    count.text = str(new_count)


func set_ingredient(_new_ingredient):
    # TODO: ingredient icons
    pass
