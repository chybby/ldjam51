extends "res://scripts/Machine.gd"

const Ingredient = preload("res://scripts/Ingredient.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    ingredient = Ingredient.new(Ingredient.IngredientType.ESPRESSO_SHOT, false, false, false)
    item_name = "Espresso Machine"
    description = "Brews Espresso Shots"
    description_image_path = ingredient.icon_file_name()


func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    print('%s espresso machine interacted with' % self)
