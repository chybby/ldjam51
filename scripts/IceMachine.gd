extends "res://scripts/Machine.gd"

const Ingredient = preload("res://scripts/Ingredient.gd")

const BlenderJug = preload("res://scripts/BlenderJug.gd")

var packed_scene = load("res://scenes/IceMachine.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    ingredient = Ingredient.new(Ingredient.IngredientType.ICE, true, false, false)
    item_name = "Ice Machine"
    description = "Dispenses Ice"
    description_image_path = ingredient.icon_file_name()
    flavour = '"feat. Ice, formerly known as Water"'

func on_interact(character, item, interact_position):
    if item != self:
        return

    var held_item = character.get_held_item()
    if held_item is BlenderJug:
        held_item.add_ingredient(ingredient)

    super(character, item, interact_position)

    print('%s ice machine interacted with' % self)
