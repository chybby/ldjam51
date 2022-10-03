extends Control

@onready var ingredient_icon : TextureRect = $IngredientIcon
@onready var ingredient_name : Label = $IngredientName

signal next_screen

func _input(event):
    if not visible:
        return

    if event.is_action_pressed('ui_next'):
        next_screen.emit()


func set_ingredient(ingredient):
    ingredient_name.text = ingredient.get_name()

    var image = Image.load_from_file(ingredient.icon_file_name())
    var texture = ImageTexture.create_from_image(image)
    ingredient_icon.texture = texture
