extends "res://scripts/InteractableItem.gd"

@export var fruit : PackedScene = null

@onready var fruit_sprite = $FruitSprite
@onready var fruit_sprite2 = $FruitSprite2
@onready var fruit_sprite3 = $FruitSprite3

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    var sprite_texture = load(fruit.instantiate().ingredient.icon_file_name())
    fruit_sprite.texture = sprite_texture
    fruit_sprite2.texture = sprite_texture
    fruit_sprite3.texture = sprite_texture

    item_name = "%s Crate" % fruit.instantiate().name

func on_interact(character, item, _interact_position):
    if item != self:
        return

    if character.is_holding_item():
        return

    print('%s fruit crate interacted with' % self)

    var new_fruit = fruit.instantiate()
    character.connect('focus_changed', new_fruit.on_focus_changed)
    character.connect('interacted_with', new_fruit.on_interact)
    character.hold_item(new_fruit)
    new_fruit.pick_up()
