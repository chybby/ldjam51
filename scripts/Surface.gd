extends "res://scripts/InteractableItem.gd"

# Something the player can place down items on.

@onready var game = $/root/Game

# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func on_interact(character, item, interact_position):
    if item != self:
        return

    print('%s surface interacted with at position %s' % [self, interact_position])

    if character.is_holding_item():
        var held_item = character.release_item()
        game.add_child(held_item)
        held_item.position = interact_position
