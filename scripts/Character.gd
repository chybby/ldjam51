extends CharacterBody3D

signal focus_changed(item)
signal interacted_with(item, held_item)

@export var speed = 1
@export var mouse_sensitivity = 0.3

@onready var camera : Camera3D = $Camera

var PICK_DISTANCE = 2

var focused_object = null
var held_item = null


# Called when the node enters the scene tree for the first time.
func _ready():
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    # Character movement
    velocity = Vector3.ZERO

    var direction = Vector3.ZERO
    if Input.is_action_pressed("move_forward"):
        direction += Vector3.FORWARD
    if Input.is_action_pressed("move_backward"):
        direction += Vector3.BACK
    if Input.is_action_pressed("move_left"):
        direction += Vector3.LEFT
    if Input.is_action_pressed("move_right"):
        direction += Vector3.RIGHT

    velocity = direction.normalized() * speed
    velocity = velocity.rotated(Vector3.UP, rotation.y)

    move_and_slide()

    # Object selection
    var mouse_position = get_viewport().get_mouse_position()
    var from = camera.project_ray_origin(mouse_position)
    var to = from + camera.project_ray_normal(mouse_position) * PICK_DISTANCE

    var space_state = get_world_3d().direct_space_state
    var result = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(from, to, 1))

    if focused_object != result.get('collider'):
        if focused_object != null:
            print("%s losing focus" % focused_object)
        focused_object = result.get('collider')
        if focused_object != null:
            print("%s gaining focus" % focused_object)
        focus_changed.emit(focused_object)


func _input(event):
    if event is InputEventMouseMotion:
        var movement = event.relative
        camera.rotation.x -= movement.y * mouse_sensitivity
        camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
        rotation.y -= movement.x * mouse_sensitivity
    elif event.is_action_pressed('interact'):
        if focused_object != null:
            interacted_with.emit(focused_object, held_item)

func _on_customer_timer_timeout():
    pass # Replace with function body.
