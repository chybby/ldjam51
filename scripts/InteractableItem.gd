extends RigidBody3D

# Something the character can look at and click on.

var focused = false

var shader_material : ShaderMaterial = null


# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func on_focus_changed(item):
    if not focused and item == self:
        print('%s recognized it received focus' % self)
        print('%s ' % shader_material)
        if shader_material != null:
            print('setting shader param to 0.5 ')
            shader_material.set_shader_parameter("strength", 0.5)
        focused = true
    elif focused and item != self:
        if shader_material != null:
            print('setting shader param to 0 ')
            shader_material.set_shader_parameter("strength", 0)
        focused = false

func on_interact(character, item, interact_position):
    if item != self:
        return

    print('%s interacted with' % self)
