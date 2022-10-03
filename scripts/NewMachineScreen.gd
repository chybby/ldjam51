extends Control

const CupDispenser = preload("res://scripts/CupDispenser.gd")
const IceMachine = preload("res://scripts/IceMachine.gd")

@onready var machine_position : Marker3D = $MachineImage/SubViewport/MachinePosition
@onready var machine_camera = $MachineImage/SubViewport/Camera3d
@onready var machine_name : Label = $MachineName
@onready var description : Label = $HBoxContainer/MarginContainer/Description
@onready var description_image : TextureRect = $HBoxContainer/DescriptionImage
@onready var flavour : Label = $Flavour

signal next_screen

func _input(event):
    if not visible:
        return

    if event.is_action_pressed('ui_next'):
        next_screen.emit()

func set_machine(machine):
    machine_name.text = machine.get_name()

    var clone = machine.packed_scene.instantiate()

    if machine is CupDispenser:
        clone.cup_size = machine.cup_size

    if machine is IceMachine:
        machine_camera.fov = 85
        machine_camera.rotation.x = deg_to_rad(-8)
    else:
        machine_camera.fov = 60
        machine_camera.rotation.x = deg_to_rad(-20)

    machine_position.add_child(clone)

    description.text = machine.get_description()

    if machine.get_description_image_path() != null:
        description_image.visible = true
        description_image.texture = load(machine.get_description_image_path())
    else:
        description_image.visible = false

    flavour.text = machine.flavour

func unset_machine():
    machine_position.remove_child(machine_position.get_children()[0])
