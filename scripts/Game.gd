extends Node

@onready var character = $Character

var machines = Array()


# Called when the node enters the scene tree for the first time.
func _ready():
    for machine in get_tree().get_nodes_in_group('machines'):
        machines.append(machine)

    print(machines)

    for machine in machines:
        character.connect('focus_changed', machine.on_focus_changed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass