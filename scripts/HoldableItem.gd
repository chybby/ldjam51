extends "res://scripts/InteractableItem.gd"

# Something the character can pick up and hold in their hand.

@onready var game = $/root/Game

@onready var sprite : Sprite3D = $Sprite3d

func on_focus_changed(item):
    super(item)

    if focused:
        sprite.modulate = Color(1, 0.988, 0.553, 1)
    else:
        sprite.modulate = Color(1, 1, 1, 1)


func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    #print('%s holdable item interacted with' % self)
    hold_or_swap(character)

func put_down():
    sprite.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y

func pick_up():
    sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED

func hold_or_swap(character):
    if character.is_holding_item():
        var held_item = character.release_item()
        game.add_child(held_item)
        held_item.position = position
        held_item.put_down()

    get_parent().remove_child(self)
    character.hold_item(self)
    pick_up()
