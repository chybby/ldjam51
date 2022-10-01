extends CharacterBody3D

enum {
    LINE_UP,
    WAIT,
    IMPATIENT,
    ANGRY,
    LEAVE_ANGRY,
    LEAVE
}

var state = LINE_UP

@onready var ap = $CustomerAnimationPlayer

func initialize(start_position):
    transform.origin = start_position

func _ready():
    pass
    
func _process(delta):
    match state: 
        WAIT:
            ap.play("Wait")

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
