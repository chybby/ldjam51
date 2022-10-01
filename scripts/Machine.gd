extends "res://scripts/InteractableItem.gd"

# Something that adds stuff to a cup when interacted with.

const Cup = preload("res://scripts/Cup.gd")

var ingredient = null

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func on_interact(character, item, interact_position):
    if item != self:
        return

    print('%s machine interacted with' % self)
    var held_item = character.get_held_item()
    if held_item is Cup:
        held_item.add_ingredient(ingredient)
