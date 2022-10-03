extends "res://scripts/InteractableItem.gd"

const BlenderJug = preload("res://scripts/BlenderJug.gd")
const MilkJug = preload("res://scripts/MilkJug.gd")

@onready var game = $/root/Game

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    item_name = "Rubbish Bin"

func on_interact(character, item, _interact_position):
    if item != self:
        return

    print('%s rubbish bin interacted with' % self)

    if character.is_holding_item():
        var held_item = character.get_held_item()
        if held_item is MilkJug or held_item is BlenderJug:
            held_item.take_contents()
        else:
            character.release_item()
            game.trash_item(held_item)
