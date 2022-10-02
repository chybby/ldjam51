extends "res://scripts/InteractableItem.gd"

var BlenderJug = load("res://scripts/BlenderJug.gd")

@onready var blender_jug_position : Marker3D = $BlenderJugPosition
@onready var blender_jug = $BlenderJug

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass

func on_interact(character, item, interact_position):
    if item != self:
        return

    print('%s blender interacted with, blender_jug is %s' % [self, blender_jug])

    var held_item = character.get_held_item()
    if held_item is BlenderJug and blender_jug == null:
        # Put the blender jug into the blender
        print('putting the held blender jug in the blender')
        character.release_item()
        self.add_child(held_item)
        held_item.position = blender_jug_position.position
        blender_jug = held_item
    elif held_item == null and blender_jug != null:
        # Blend the blender jug
        print('blending the blender jug in the blender')
        blender_jug.blend_contents()

    super(character, item, interact_position)
