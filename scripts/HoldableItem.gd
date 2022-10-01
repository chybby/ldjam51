extends "res://scripts/InteractableItem.gd"

# Something the character can pick up and hold in their hand.

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    print('%s holdable item interacted with' % self)

    #TODO: maybe don't swap - you may want to interact with a cup while holding a bottle of milk.

    if character.is_holding_item():
        var held_item = character.release_item()
        get_parent().add_child(held_item)
        held_item.position = position

    get_parent().remove_child(self)
    character.hold_item(self)
