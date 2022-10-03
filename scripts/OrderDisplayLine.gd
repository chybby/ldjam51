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

    ingredient_modifier.visible = true

    if new_ingredient.frothed:
        var frothed_image = Image.load_from_file('res://assets/frothed.png')
        var frothed_texture = ImageTexture.create_from_image(frothed_image)
        ingredient_modifier.texture = frothed_texture
    elif new_ingredient.blended:
        var blended_image = Image.load_from_file('res://assets/blended.png')
        var blended_texture = ImageTexture.create_from_image(blended_image)
        ingredient_modifier.texture = blended_texture
    else:
        ingredient_modifier.visible = false
