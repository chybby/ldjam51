extends Node

const EspressoMachine = preload("EspressoMachine.gd")


@onready var character = $Character

var interactables = Array()


# Called when the node enters the scene tree for the first time.
func _ready():
    for interactable in get_tree().get_nodes_in_group('interactable'):
        print(interactable is EspressoMachine)
        interactables.append(interactable)

    print(interactables)

    for interactable in interactables:
        character.connect('focus_changed', interactable.on_focus_changed)
        character.connect('interacted_with', interactable.on_interact)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass