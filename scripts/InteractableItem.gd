extends StaticBody3D

var focused = false

@onready var shader_material : ShaderMaterial = $Model.mesh.material.next_pass


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func on_focus_changed(item):
    if item == self:
        print('%s recognized it received focus' % self)
        shader_material.set_shader_parameter("strength", 0.5)
        focused = true
    else:
        shader_material.set_shader_parameter("strength", 0)
        focused = false

func on_interact(item, held_item):
    if item != self:
        return

    print('%s interactable item interacted with' % self)
