extends "res://scripts/InteractableItem.gd"

#TODO: you can put things in fridge from the side
#TODO: do we need this script?

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    item_name = "Fridge"

func on_interact(_character, item, _interact_position):
    if item != self:
        return

    print('%s fridge interacted with' % self)
