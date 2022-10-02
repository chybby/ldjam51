extends "res://scripts/HoldableItem.gd"

const Milk = preload("res://scripts/Milk.gd")
const MilkFrother = preload("res://scripts/MilkFrother.gd")

var ingredients = Array()

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
    if held_item is Milk and ingredients.is_empty():
        ingredients.append(held_item.ingredient)
        print('milk jug has: %s' % ', '.join(ingredients))
    elif get_parent() is MilkFrother:
        # Only take from milk frother if hand is empty - do not replace.
        if held_item == null:
            get_parent().milk_jug = null
            hold_or_swap(character)
    else:
        # If not in a milk frother, replace with held item as normal.
        hold_or_swap(character)

    print('%s milk jug interacted with' % self)

func froth_contents():
    var new_ingredients = Array()
    if ingredients.is_empty():
        print('not frothing, milk jug is empty')
        return
    for ingredient in ingredients:
        new_ingredients.append('frothed ' + ingredient)

    ingredients = new_ingredients
    print('milk jug has: %s' % ', '.join(ingredients))

func take_contents():
    var previous_ingredients = ingredients
    ingredients = Array()
    print('milk jug has: %s' % ', '.join(ingredients))
    return previous_ingredients

func has_contents():
    return not ingredients.is_empty()
