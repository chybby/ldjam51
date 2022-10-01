extends "res://scripts/InteractableItem.gd"

@onready var character = $/root/Game/Character

# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func on_interact(item, held_item, interact_position):
    if item != self:
        return

    #TODO: make sure you can only place things on top of surfaces

    print('%s surface interacted with at position %s' % [self, interact_position])

    if held_item != null:
        character.release_item()
        get_parent().add_child(held_item)
        held_item.position = interact_position
