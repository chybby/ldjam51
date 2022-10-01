extends "res://scripts/InteractableItem.gd"

#TODO: make fridge door interactable

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func on_interact(character, item, interact_position):
    if item != self:
        return

    print('%s fridge interacted with' % self)

    if is_open:
        rotation.y = 0
        is_open = false
    else:
        rotation.y = deg_to_rad(-135)
        is_open = true