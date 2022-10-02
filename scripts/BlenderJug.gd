extends "res://scripts/HoldableItem.gd"

const Fruit = preload("res://scripts/Fruit.gd")
const Milk = preload("res://scripts/Milk.gd")
const Blender = preload("res://scripts/Blender.gd")

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
    if held_item is Fruit:
        character.release_item()
        add_ingredient(held_item.ingredient)
        held_item.queue_free()
    elif held_item is Milk:
        add_ingredient(held_item.ingredient)
    elif get_parent() is Blender:
        # Only take from blender if hand is empty - do not replace.
        if held_item == null:
            get_parent().blender_jug = null
            hold_or_swap(character)
    else:
        # If not in a blender, replace with held item as normal.
        hold_or_swap(character)

    print('%s blender jug interacted with' % self)

func add_ingredient(ingredient):
    ingredients.append(ingredient)
    print('blender jug has: %s' % ', '.join(ingredients))

func blend_contents():
    # TODO: only blend blendable ingredients - leave milk alone
    var new_ingredients = Array()
    if ingredients.is_empty():
        print('not blending, blender jug is empty')
        return
    for ingredient in ingredients:
        new_ingredients.append('blended ' + ingredient)

    ingredients = new_ingredients
    print('blender jug has: %s' % ', '.join(ingredients))

func take_contents():
    var previous_ingredients = ingredients
    ingredients = Array()
    print('blender jug has: %s' % ', '.join(ingredients))
    return previous_ingredients

func has_contents():
    return not ingredients.is_empty()
