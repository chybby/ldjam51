extends "res://scripts/HoldableItem.gd"

# A holdable thing that adds stuff to a cup when interacted with.

# TODO: milk spoils if left out of the fridge?

var ingredient = null

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    #print('%s milk interacted with' % self)
