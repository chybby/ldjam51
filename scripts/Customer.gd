extends CharacterBody3D

const DrinkOrder = preload("res://scripts/DrinkOrder.gd")
const Cup = preload("res://scripts/Cup.gd")

const BabyFrames = preload("res://resources/BabyFrames.tres")
const HipsterFrames = preload("res://resources/HipsterFrames.tres")
const KarenFrames = preload("res://resources/KarenFrames.tres")
const TradieFrames = preload("res://resources/TradieFrames.tres")

const BabyVoice = preload( "res://assets/audio/SFX/kid_oof.wav")
const HipsterVoice = preload("res://assets/audio/SFX/girl_ouch.wav")
const KarenVoice = preload( "res://assets/audio/SFX/yelp_girl.wav")
const TradieVoice = preload("res://assets/audio/SFX/manchild_oof.wav")

const FRAMES = [BabyFrames, HipsterFrames, KarenFrames, TradieFrames]

signal left(wasAngry, spot)

enum {
    LINE_UP,
    WAIT,
    IMPATIENT,
    LEAVE_ANGRY,
    HIT,
    LEAVE,
}

var state = LINE_UP
var targetNode
var spotNode
var drink_order

@export var speed = 5.0
@export var patience = 20
@export var patence_lost_on_wrong_order = 5

@onready var sprite : AnimatedSprite3D = $Sprite
@onready var nav_agent = $NavigationAgent3d
@onready var order_display_3d : Sprite3D = $OrderDisplay3d
@onready var viewport : SubViewport = $OrderDisplay3d/SubViewport
@onready var order_display : Control = $OrderDisplay3d/SubViewport/OrderDisplay
@onready var order_display_position : Marker3D = $OrderDisplayPosition
@onready var patience_timer : Timer = $PatienceTimer

@onready var cup_detection_area = $CupDetectionArea
@onready var cup_position = $CupDetectionArea/CupPosition

var has_drink = false

func initialize(start_position, spot, order):
    var r_sprite = FRAMES[randi() % FRAMES.size()]
    sprite.set_sprite_frames(r_sprite)
    set_voice(r_sprite)

    transform.origin = start_position

    drink_order = order
    order_display.display_order(drink_order)

    order_display.draw.connect(_on_order_display_draw)

    order_display.visible = false

    sprite.animation_finished.connect(_on_animation_finished)

    spotNode = spot

    set_nav_target(spotNode)
    
func set_voice(r_sprite):
    var soundPlayer = $SoundYelp
    match r_sprite:
        BabyFrames:
            soundPlayer.stream = BabyVoice
        HipsterFrames:
            soundPlayer.stream = HipsterVoice
        KarenFrames:
            soundPlayer.stream = KarenVoice
            soundPlayer.unit_db = -12
        TradieFrames:
            soundPlayer.stream = TradieVoice
            soundPlayer.unit_db = -12
            
        
func _on_animation_finished():
    if sprite.animation == 'hit':
        sprite.animation = 'idle'
        if state == HIT:
            state = LEAVE
            set_nav_target(get_node("../Cafe/Door"))

func _on_order_display_draw():
    var order_display_height = order_display.get_node("Panel").size.y
    viewport.size.y = order_display_height
    order_display_3d.position = order_display_position.position
    # TODO: Don't know why this is 100.
    order_display_3d.position.y += order_display_height/100/2

func _process(_delta):
    order_display.set_patience(patience_timer.time_left, patience_timer.wait_time)
    if not patience_timer.is_stopped() and patience_timer.time_left < 5 and state != IMPATIENT:
        get_impatient()

    if sprite.animation != 'hit':
        match state:
            LINE_UP:
                sprite.animation = 'run'
            WAIT:
                sprite.animation = 'idle'
            IMPATIENT:
                sprite.animation = 'impatient'
            LEAVE:
                sprite.animation = 'run'
            HIT:
                sprite.animation = 'hit'
            LEAVE_ANGRY:
                sprite.animation = 'angry_run'


func start_waiting():
    state = WAIT
    patience_timer.start(patience)
    order_display.visible = true
    cup_detection_area.monitoring = true
    print("ok im waiting for my drink now")

func get_impatient():
    state = IMPATIENT
    print("WHERES ME DRINK")

func leave_angry():
    print("times up im out this bitch")
    state = LEAVE_ANGRY
    set_nav_target(get_node("../Cafe/Door"))
    order_display.visible = false

func receive_drink(cup):
    cup_detection_area.set_deferred("monitoring", false)
    cup.set_collision_layer(0)
    has_drink = true

    order_display.visible = false

    patience_timer.stop()

    cup.get_parent().remove_child(cup)
    self.add_child(cup)
    cup.position = cup_position.position
    cup.freeze = true
    state = HIT

func exit_cafe():
    var isAngry = false
    if (state == LEAVE_ANGRY):
        isAngry = true
    print("later bitch")
    left.emit(isAngry, spotNode)
    queue_free()

func set_nav_target(node):
    targetNode = node
    nav_agent.set_target_location(targetNode.position)

func _physics_process(_delta):
    if(nav_agent.distance_to_target() < .7):
        if(state == LINE_UP):
            start_waiting()
        elif(state == LEAVE_ANGRY || state == LEAVE):
            exit_cafe()
        return

    var target = nav_agent.get_next_location()
    var pos = get_global_transform().origin

    #print(speed)

    var new_vel : Vector3 = (target-pos).normalized() * speed
    nav_agent.set_velocity(new_vel)

func _on_navigation_agent_3d_velocity_computed(safe_velocity):
    velocity = safe_velocity
    move_and_slide()

func _on_patience_timer_timeout():
    leave_angry()

func _on_area_3d_body_entered(body : Node3D):
    if body is Cup:
        if has_drink:
            return

        sprite.animation = 'hit'
        $SoundYelp.play()

        if drink_order.is_fulfilled_by(body):
            receive_drink(body)
        else:
            if (patience_timer.time_left - patence_lost_on_wrong_order) <= 0:
                patience_timer.start(0.5)
            else:
                patience_timer.start(patience_timer.time_left - patence_lost_on_wrong_order)
            patience_timer.wait_time = patience
