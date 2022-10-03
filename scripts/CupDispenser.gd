extends "res://scripts/InteractableItem.gd"

const Cup = preload("res://scripts/Cup.gd")

var packed_scene = load("res://scenes/CupDispenser.tscn")

@export var cup : PackedScene = null
@export var cup_size : Cup.CupSize = Cup.CupSize.MEDIUM

@onready var cup_sprite = $CupSprite
@onready var cup_sprite2 = $CupSprite2
@onready var cup_sprite3 = $CupSprite3

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    # var child_scale
    # match cup_size:
    #     Cup.CupSize.SMALL:
    #         child_scale = 0.6
    #     Cup.CupSize.MEDIUM:
    #         child_scale = 1
    #     Cup.CupSize.LARGE:
    #         child_scale = 1.4
    # $Model.scale = Vector3.ONE * child_scale
    # $Model.position *= child_scale
    # $Collision.scale = Vector3.ONE * child_scale
    # $Collision.position *= child_scale

    item_name = "%s Cup Dispenser" % size_name()
    description = "A stack of %s cups" % size_name().to_lower()
    description_image_path = get_cup_icon_path(cup_size)

    var sprite_texture = load(get_cup_sprite_path(cup_size))
    cup_sprite.texture = sprite_texture
    cup_sprite2.texture = sprite_texture
    cup_sprite3.texture = sprite_texture

func get_cup_icon_path(order_cup_size):
    match order_cup_size:
        Cup.CupSize.SMALL: return 'res://assets/smallcup.png'
        Cup.CupSize.MEDIUM: return 'res://assets/mediumcup.png'
        Cup.CupSize.LARGE: return 'res://assets/largecup.png'

func get_cup_sprite_path(order_cup_size):
    match order_cup_size:
        Cup.CupSize.SMALL: return 'res://assets/empty_small_cup.png'
        Cup.CupSize.MEDIUM: return 'res://assets/emptymediumcup.png'
        Cup.CupSize.LARGE: return 'res://assets/empty_large_cup.png'

func size_name():
    match cup_size:
        Cup.CupSize.SMALL:
            return "Small"
        Cup.CupSize.MEDIUM:
            return "Medium"
        Cup.CupSize.LARGE:
            return "Large"

func on_interact(character, item, _interact_position):
    if item != self:
        return

    if character.is_holding_item():
        return

    print('%s cup dispenser interacted with' % self)

    var new_cup = cup.instantiate()
    new_cup.set_size(cup_size)
    character.connect('focus_changed', new_cup.on_focus_changed)
    character.connect('interacted_with', new_cup.on_interact)
    character.hold_item(new_cup)
    new_cup.pick_up()
