extends "res://scripts/Machine.gd"

const Ingredient = preload("res://scripts/Ingredient.gd")

var packed_scene = load("res://scenes/HazelnutSyrup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    ingredient = Ingredient.new(Ingredient.IngredientType.HAZELNUT_SYRUP, false, false, false)
    item_name = "Hazelnut Syrup Pump"
    description = "Dispenses Hazelnut Syrup"
    description_image_path = ingredient.icon_file_name()
    flavour = '"Warning. Contains nuts."'

func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    print('%s hazelnut syrup pump interacted with' % self)
