extends CharacterBody3D

signal focus_changed(item)
signal interacted_with(character, item, interact_position)

@export var speed = 5
@export var yeet_strength = 10
@export var yeet_angle = 30
@export var mouse_sensitivity = 0.3

@onready var camera : Camera3D = $Camera
@onready var held_item_position : Marker3D = $Camera/HeldItemPosition
@onready var game = $/root/Game

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var PICK_DISTANCE = 2

var focused_item = null
var focused_item_position = null
var held_item = null

var game_paused = false

var initial_transform = null


# Called when the node enters the scene tree for the first time.
func _ready():
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
    initial_transform = transform

func reset():
    transform = initial_transform
    camera.rotation = Vector3.ZERO

# Called every physics frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
    if game_paused:
        return
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

    # Add the gravity.
    if not is_on_floor():
        velocity.y -= gravity

    move_and_slide()

    # Object selection
    var mouse_position = get_viewport().get_mouse_position()
    var from = camera.project_ray_origin(mouse_position)
    var to = from + camera.project_ray_normal(mouse_position) * PICK_DISTANCE

    var space_state = get_world_3d().direct_space_state
    var result = space_state.intersect_ray(PhysicsRayQueryParameters3D.create(from, to, 1))
    focused_item_position = result.get('position')

    if focused_item != result.get('collider'):
        focused_item = result.get('collider')
        focus_changed.emit(focused_item)


func _input(event):
    if game_paused:
        return

    if event is InputEventMouseMotion:
        var movement = event.relative
        camera.rotation.x -= movement.y * mouse_sensitivity
        camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
        rotation.y -= movement.x * mouse_sensitivity
    elif event.is_action_pressed('interact'):
        print('character interacting with %s while holding %s' % [focused_item, held_item])
        if focused_item != null:
            interacted_with.emit(self, focused_item, focused_item_position)
    elif event.is_action_pressed('yeet'):
        print('YEET')
        throw_item()

func is_holding_item():
    return held_item != null

func get_held_item():
    return held_item

func hold_item(item):
    print("character picked up item %s" % item)
    held_item = item
    if held_item == focused_item:
        focused_item = null
        focus_changed.emit(focused_item)
    camera.add_child(item)
    item.position = held_item_position.position
    item.rotation = Vector3.ZERO
    item.freeze = true
    item.set_collision_layer(0)
    item.sprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED

func release_item():
    if held_item == null:
        return null
    camera.remove_child(held_item)
    # Put down items are only on layer 1.
    held_item.set_collision_layer(1)
    held_item.rotation = self.rotation
    var previously_held_item = held_item
    held_item.sprite.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
    held_item = null
    return previously_held_item

func throw_item():
    if held_item == null:
        return null
    camera.remove_child(held_item)
    # Thrown cups need to be on collision layer 2 as well.
    held_item.set_collision_layer(3)
    held_item.freeze = false
    held_item.put_down()
    var direction = Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
    # Angle the yeet upwards.
    direction = direction.rotated(direction.cross(Vector3.UP), deg_to_rad(yeet_angle))
    held_item.set_linear_velocity(direction * yeet_strength)
    game.add_child(held_item)
    held_item.position = held_item_position.global_position
    var previously_held_item = held_item
    held_item = null
    return previously_held_item


func _on_game_game_was_paused(paused):
    game_paused = paused
