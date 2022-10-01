extends "res://scripts/InteractableItem.gd"

const Cup = preload("res://scripts/Cup.gd")

@export var cup : PackedScene = null
@export var cup_size : Cup.CupSize

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    match cup_size:
        Cup.CupSize.SMALL:
            $Model.scale = Vector3.ONE * 0.6
            $Collision.scale = Vector3.ONE * 0.6
        Cup.CupSize.MEDIUM:
            $Model.scale = Vector3.ONE * 1
            $Collision.scale = Vector3.ONE * 1
        Cup.CupSize.LARGE:
            $Model.scale = Vector3.ONE * 1.4
            $Collision.scale = Vector3.ONE * 1.4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass


func on_interact(character, item, interact_position):
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
