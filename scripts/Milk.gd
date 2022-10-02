extends "res://scripts/HoldableItem.gd"

# A holdable thing that adds stuff to a cup when interacted with.

# TODO: milk spoils if left out of the fridge?

var Cup = load("res://scripts/Cup.gd")

var ingredient = null

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

    super(character, item, interact_position)

    print('%s milk interacted with' % self)

    #TODO: do we want holding a cup and interacting with milk to work?
    # var held_item = character.get_held_item()
    # if held_item is Cup:
    #     held_item.add_ingredient(ingredient)
