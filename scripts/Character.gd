extends CharacterBody3D

@export var speed = 1
@export var mouse_sensitivity = 0.3

@onready var camera : Camera3D = $Camera
@onready var body : Camera3D = $Camera


# Called when the node enters the scene tree for the first time.
func _ready():
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
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


func _input(event):
    if event is InputEventMouseMotion:
        var movement = event.relative
        camera.rotation.x -= movement.y * mouse_sensitivity
        camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
        rotation.y -= movement.x * mouse_sensitivity