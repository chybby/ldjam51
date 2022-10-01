extends "res://scripts/InteractableItem.gd"

@onready var character = %Character

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func on_interact(item, held_item, interact_position):
    if item != self:
        return

    super(item, held_item, position)

    print('%s holdable item interacted with' % self)

    #TODO: maybe don't swap - you may want to interact with a cup while holding a bottle of milk.

    if held_item != null:
        character.release_item()
        get_parent().add_child(held_item)
        held_item.position = position

    get_parent().remove_child(self)
    character.hold_item(self)
