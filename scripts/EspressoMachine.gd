extends "res://scripts/Machine.gd"

const Cup = preload("res://scripts/Cup.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func on_interact(item, held_item, interact_position):
    if item != self:
        return

    print('%s espresso machine interacted with' % self)

    if held_item is Cup:
        print('%s espresso machine interacted with while holding cup' % self)
        held_item.add_ingredient('espresso shot')
