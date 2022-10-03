extends "res://scripts/Machine.gd"

const Ingredient = preload("res://scripts/Ingredient.gd")

var packed_scene = load("res://scenes/VanillaSyrup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    ingredient = Ingredient.new(Ingredient.IngredientType.VANILLA_SYRUP, false, false, false)
    item_name = "Vanilla Syrup Pump"
    description = "Dispenses Vanilla Syrup"
    description_image_path = ingredient.icon_file_name()
    flavour = '"Criminally underrated"'

func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    print('%s vanilla syrup pump interacted with' % self)
