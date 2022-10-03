extends CenterContainer

@onready var count = $HBoxContainer/Count
@onready var ingredient : TextureRect = $HBoxContainer/Container/Ingredient
@onready var ingredient_modifier : TextureRect = $HBoxContainer/Container/Modifier


func set_count(new_count):
    count.text = str(new_count)


func set_ingredient(new_ingredient):
    var image = Image.load_from_file(new_ingredient.icon_file_name())
    var texture = ImageTexture.create_from_image(image)
    ingredient.texture = texture

    #TODO: modifier icons
    ingredient_modifier.visible = false\
