extends "res://scripts/HoldableItem.gd"

var ingredients = Array()

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

    super(item, held_item, position)

    print('%s cup interacted with' % self)