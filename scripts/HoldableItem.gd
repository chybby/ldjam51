extends "res://scripts/InteractableItem.gd"

@onready var character = %Character

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func on_interact(item, held_item):
    if item != self:
        return

    super(item, held_item)

    print('%s holdable item interacted with' % self)

    if held_item != null:
        held_item.get_parent().remove_child(held_item)
        get_parent().add_child(held_item)
        held_item.set_collision_layer(1)

    get_parent().remove_child(self)
    character.hold_item(self)
