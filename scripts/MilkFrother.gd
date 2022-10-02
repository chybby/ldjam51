extends "res://scripts/InteractableItem.gd"

var MilkJug = load("res://scripts/MilkJug.gd")

@onready var milk_jug_position : Marker3D = $MilkJugPosition
@onready var milk_jug = $MilkJug

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

func on_interact(character, item, interact_position):
    if item != self:
        return

    print('%s milk frother interacted with, milk_jug is %s' % [self, milk_jug])

    var held_item = character.get_held_item()
    if held_item is MilkJug and milk_jug == null:
        # Put the milk jug into the frother
        print('putting the held milk jug in the milk frother')
        character.release_item()
        self.add_child(held_item)
        held_item.position = milk_jug_position.position
        milk_jug = held_item
    elif held_item == null and milk_jug != null:
        # Froth the milk jug
        print('frothing the milk jug in the milk frother')
        milk_jug.froth_contents()

    super(character, item, interact_position)

