extends "res://scripts/InteractableItem.gd"

# Something that adds stuff to a cup when interacted with.

const Cup = preload("res://scripts/Cup.gd")

var ingredient = null

func on_interact(character, item, _interact_position):
    if item != self:
        return

    #print('%s machine interacted with' % self)
    var held_item = character.get_held_item()
    if held_item is Cup:
        held_item.add_ingredient(ingredient.clone())