extends "res://scripts/HoldableItem.gd"

var ingredient = null

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    #print('%s fruit interacted with' % self)