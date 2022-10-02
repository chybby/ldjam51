extends RigidBody3D

# Something the character can look at and click on.

var focused = false

var shader_material : ShaderMaterial = null


func on_focus_changed(item):
    if not focused and item == self:
        #print('%s recognized it received focus' % self)
        #print('%s ' % shader_material)
        if shader_material != null:
            #print('setting shader param to 0.5 ')
            shader_material.set_shader_parameter("enable", true)
        focused = true
    elif focused and item != self:
        if shader_material != null:
            #print('setting shader param to 0 ')
            shader_material.set_shader_parameter("enable", false)
        focused = false

func on_interact(_character, item, _interact_position):
    if item != self:
        return

    #print('%s interacted with' % self)
