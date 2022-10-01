extends "res://scripts/InteractableItem.gd"

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

    print('%s rubbish bin interacted with' % self)

    if character.is_holding_item():
        var held_item = character.release_item()
        held_item.queue_free()
