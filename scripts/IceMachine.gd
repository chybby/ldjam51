extends "res://scripts/Machine.gd"

const BlenderJug = preload("res://scripts/BlenderJug.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    ingredient = 'ice'


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func on_interact(character, item, interact_position):
    if item != self:
        return

    var held_item = character.get_held_item()
    if held_item is BlenderJug:
        held_item.add_ingredient(ingredient)

    super(character, item, interact_position)

    print('%s ice machine interacted with' % self)
