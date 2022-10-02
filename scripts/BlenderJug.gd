extends "res://scripts/HoldableItem.gd"

const IngredientList = preload("res://scripts/IngredientList.gd")
const Fruit = preload("res://scripts/Fruit.gd")
const Milk = preload("res://scripts/Milk.gd")
const Blender = preload("res://scripts/Blender.gd")

var ingredients = IngredientList.new()

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
        add_ingredient(held_item.ingredient.clone())
        held_item.queue_free()
    elif held_item is Milk:
        add_ingredient(held_item.ingredient.clone())
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
    ingredients.add_ingredient(ingredient)
    print('blender jug has: %s' % ingredients)

func blend_contents():
    ingredients.blend()

    print('blender jug has: %s' % ingredients)

func take_contents():
    var previous_ingredients = ingredients
    ingredients = IngredientList.new()
    print('blender jug has: %s' % ingredients)
    return previous_ingredients

func has_contents():
    return not ingredients.is_empty()
