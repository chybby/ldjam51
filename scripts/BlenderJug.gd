extends "res://scripts/HoldableItem.gd"

const IngredientList = preload("res://scripts/IngredientList.gd")
const Fruit = preload("res://scripts/Fruit.gd")
const Milk = preload("res://scripts/Milk.gd")
const Blender = preload("res://scripts/Blender.gd")

@onready var contents = $Contents
@onready var blended_contents = $BlendedContents
@onready var lines = $Lines

var ingredients = IngredientList.new()

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    item_name = "Blender Jug"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    pass

func on_interact(character, item, _interact_position):
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
    contents.visible = true
    var color = ingredients.get_unblended_color()
    contents.modulate = color
    color = ingredients.get_blended_color()
    blended_contents.modulate = color
    print('blender jug has: %s' % ingredients)

func blend_contents():
    ingredients.blend()
    blended_contents.visible = true
    contents.visible = false
    var color = ingredients.get_color()
    blended_contents.modulate = color

    print('blender jug has: %s' % ingredients)

func has_unblended_contents():
    for ingredient_count in ingredients.get_ingredients():
        var ingredient = ingredient_count[0]
        if ingredient.is_blendable and not ingredient.blended:
            return true

    return false

func take_contents():
    contents.visible = false
    blended_contents.visible = false
    var previous_ingredients = ingredients
    ingredients = IngredientList.new()
    print('blender jug has: %s' % ingredients)
    return previous_ingredients

func has_contents():
    return not ingredients.is_empty()

func put_back(blender):
    blender.place_blender_jug(self)

func put_down():
    super()
    contents.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
    blended_contents.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
    lines.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
    contents.render_priority -= 10
    blended_contents.render_priority -= 10
    lines.render_priority -= 10

func pick_up():
    super()
    contents.billboard = BaseMaterial3D.BILLBOARD_ENABLED
    blended_contents.billboard = BaseMaterial3D.BILLBOARD_ENABLED
    lines.billboard = BaseMaterial3D.BILLBOARD_ENABLED
    contents.render_priority += 10
    blended_contents.render_priority += 10
    lines.render_priority += 10
