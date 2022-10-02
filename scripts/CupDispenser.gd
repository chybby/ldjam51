extends "res://scripts/InteractableItem.gd"

const Cup = preload("res://scripts/Cup.gd")

@export var cup : PackedScene = null
@export var cup_size : Cup.CupSize

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    var child_scale
    match cup_size:
        Cup.CupSize.SMALL:
            child_scale = 0.6
        Cup.CupSize.MEDIUM:
            child_scale = 1
        Cup.CupSize.LARGE:
            child_scale = 1.4
    $Model.scale = Vector3.ONE * child_scale
    $Model.position *= child_scale
    $Collision.scale = Vector3.ONE * child_scale
    $Collision.position *= child_scale


func on_interact(character, item, _interact_position):
    if item != self:
        return

    if character.is_holding_item():
        return

    print('%s cup dispenser interacted with' % self)

    var new_cup = cup.instantiate()
    new_cup.set_size(cup_size)
    #TODO: add to interactables list? do we need it?
    character.connect('focus_changed', new_cup.on_focus_changed)
    character.connect('interacted_with', new_cup.on_interact)
    character.hold_item(new_cup)
