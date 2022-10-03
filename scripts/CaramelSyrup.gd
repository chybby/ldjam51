extends "res://scripts/Machine.gd"

const Ingredient = preload("res://scripts/Ingredient.gd")

var packed_scene = load("res://scenes/CaramelSyrup.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    ingredient = Ingredient.new(Ingredient.IngredientType.CARAMEL_SYRUP, false, false, false)
    item_name = "Caramel Syrup Pump"
    description = "Dispenses Caramel Syrup"
    description_image_path = ingredient.icon_file_name()
    flavour = '"It\'ll cara-MELt in your mouth"'

func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    print('%s caramel syrup pump interacted with' % self)
