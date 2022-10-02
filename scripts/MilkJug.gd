extends "res://scripts/HoldableItem.gd"

const Milk = preload("res://scripts/Milk.gd")
const MilkFrother = preload("res://scripts/MilkFrother.gd")

var milk = null

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func on_interact(character, item, interact_position):
    if item != self:
        return

    var held_item = character.get_held_item()
    if held_item is Milk and milk == null:
        milk = held_item.ingredient
        print('milk jug has: %s' % milk)
    else:
        if get_parent() is MilkFrother:
            get_parent().milk_jug = null
        super(character, item, interact_position)

    print('%s milk jug interacted with' % self)

func froth_contents():
    if milk == null:
        print('not frothing milk jug, it is empty')
        return
    milk = 'frothed ' + milk
    print('milk jug has: %s' % milk)

func take_contents():
    var previous_milk = milk
    milk = null
    print('milk jug has: %s' % milk)
    return previous_milk