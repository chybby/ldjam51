extends CharacterBody3D

signal left(wasAngry, spot)
signal orderDrink()

enum {
    LINE_UP,
    WAIT,
    IMPATIENT,
    LEAVE_ANGRY,
    LEAVE
}

var state = LINE_UP
var targetNode
var spotNode
var drink_order

const SPEED = 5.0
const patience = 3

#@onready var ap = $CustomerAnimationPlayer
@onready var nav_agent = $NavigationAgent3d
@onready var timer = $PatienceTimer

func initialize(start_position, spot, d_order):
    transform.origin = start_position
    drink_order = d_order
    spotNode = spot
    if nav_agent == null:
        nav_agent = $NavigationAgent3d

    set_nav_target(spotNode)

func _ready():
    pass

func _process(delta):
#    match state:
#        WAIT:
#            ap.play("Wait")
#if(timer.time_left < 5)
#    get_impatient()
#        IMPATIENT:
#            ap.play("Impatient")
    pass


func order_drink():
    #generate drinkorder from drinkordermaker
    orderDrink.emit(drink_order)
    start_waiting()

func start_waiting():
    state = WAIT
    if(timer == null):
        timer = $PatienceTimer
    timer.start(patience)
    print("ok im waiting for my drink now")

func get_impatient():
    state = IMPATIENT
    print("WHERES ME DRINK")

func leave_angry():
    print("times up im out this bitch")
    state = LEAVE_ANGRY
    set_nav_target(get_node("../Cafe/Door"))

func receive_drink():
    state = LEAVE
    set_nav_target(get_node("../Cafe/Door"))

func exit_cafe():
    var isAngry = false
    if(state == LEAVE_ANGRY):
        isAngry = true
    print("later bitch")
    left.emit(isAngry, spotNode)
    queue_free()

func set_nav_target(node):
    targetNode = node
    nav_agent.set_target_location(targetNode.position)

func _physics_process(delta):
    if(nav_agent.distance_to_target() < .7):
        if(state == LINE_UP):
            order_drink()
        elif(state == LEAVE_ANGRY || state == LEAVE):
            exit_cafe()
        return

    var target = nav_agent.get_next_location()
    var pos = get_global_transform().origin

    var new_vel : Vector3 = (target-pos).normalized() * SPEED
    nav_agent.set_velocity(new_vel)

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
    velocity = safe_velocity
    move_and_slide()

func _on_patience_timer_timeout():
    leave_angry()
