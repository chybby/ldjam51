extends "res://scripts/InteractableItem.gd"

@export var cup : PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass


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
    #TODO: add to interactables list? do we need it?
    character.connect('focus_changed', new_cup.on_focus_changed)
    character.connect('interacted_with', new_cup.on_interact)
    character.hold_item(new_cup)
