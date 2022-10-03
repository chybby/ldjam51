extends "res://scripts/InteractableItem.gd"

#TODO: animate fridge door

@onready var animation_player : AnimationPlayer = $AnimationPlayer

var is_open = false

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    item_name = "Fridge Door"


func on_interact(_character, item, _interact_position):
    if item != self:
        return

    print('%s fridge interacted with' % self)

    if is_open:
        close()
    else:
        open()

func close():
    animation_player.play_backwards('door_open')
    is_open = false

func open():
    animation_player.play('door_open')
    is_open = true