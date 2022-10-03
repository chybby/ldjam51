extends Control

@onready var ingredient_icon : TextureRect = $IngredientIcon
@onready var ingredient_name : Label = $IngredientName
@onready var flavour : Label = $Flavour

signal next_screen

func _input(event):
    if not visible:
        return

    if event.is_action_pressed('ui_next'):
        next_screen.emit()


func set_ingredient(ingredient):
    ingredient_name.text = ingredient.get_name()

    ingredient_icon.texture = load(ingredient.icon_file_name())

    flavour.text = ingredient.get_flavour()
