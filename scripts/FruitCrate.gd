extends "res://scripts/InteractableItem.gd"

@export var fruit : PackedScene = null

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    # TODO: display the fruit on the crate

    item_name = "%s Crate" % fruit.instantiate().name

func on_interact(character, item, _interact_position):
    if item != self:
        return

    if character.is_holding_item():
        return

    print('%s fruit crate interacted with' % self)

    var new_fruit = fruit.instantiate()
    #TODO: add to interactables list? do we need it?
    character.connect('focus_changed', new_fruit.on_focus_changed)
    character.connect('interacted_with', new_fruit.on_interact)
    character.hold_item(new_fruit)
