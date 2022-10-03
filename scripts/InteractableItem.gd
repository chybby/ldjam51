extends RigidBody3D

# Something the character can look at and click on.

var focused = false

var shader_material : ShaderMaterial = null

var item_name = null
var description = null
var flavour = ""
var description_image_path = null

var initial_position

func _ready():
    pass

func set_initial_position():
    initial_position = position

func on_focus_changed(item):
    if not focused and item == self:
        if shader_material != null:
            shader_material.set_shader_parameter("enable", true)
        focused = true
    elif focused and item != self:
        if shader_material != null:
            shader_material.set_shader_parameter("enable", false)
        focused = false

func on_interact(_character, item, _interact_position):
    if item != self:
        return

    #print('%s interacted with' % self)

func get_name():
    return item_name

func get_description():
    return description

func get_description_image_path():
    return description_image_path

func reset_position():
    position = initial_position
