extends "res://scripts/Machine.gd"

const Ingredient = preload("res://scripts/Ingredient.gd")

var packed_scene = load("res://scenes/HotWaterDispenser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    ingredient = Ingredient.new(Ingredient.IngredientType.HOT_WATER, false, false, false)
    item_name = "Hot Water Tap"
    description = "Dispenses Hot Water"
    description_image_path = ingredient.icon_file_name()

func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    print('%s hot water dispenser interacted with' % self)
