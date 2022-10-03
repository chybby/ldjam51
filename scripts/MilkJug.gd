extends "res://scripts/HoldableItem.gd"

const IngredientList = preload("res://scripts/IngredientList.gd")
const Milk = preload("res://scripts/Milk.gd")
const MilkFrother = preload("res://scripts/MilkFrother.gd")

@onready var contents = $Contents
@onready var frothed_contents = $FrothedContents

var ingredients = IngredientList.new()

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    item_name = "Milk Jug"

func on_interact(character, item, _interact_position):
    if item != self:
        return

    var held_item = character.get_held_item()
    if held_item is Milk:
        add_ingredient(held_item.ingredient.clone())
    elif get_parent() is MilkFrother:
        # Only take from milk frother if hand is empty - do not replace.
        if held_item == null:
            get_parent().milk_jug = null
            hold_or_swap(character)
    else:
        # If not in a milk frother, replace with held item as normal.
        hold_or_swap(character)

    print('%s milk jug interacted with' % self)

func add_ingredient(ingredient):
    $SoundPour.play()
    contents.visible = true
    ingredients.add_ingredient(ingredient)
    var color = ingredients.get_color()
    contents.modulate = color
    frothed_contents.modulate = color
    print('milk jug has: %s' % ingredients)

func froth_contents():
    ingredients.froth()
    frothed_contents.visible = true
    contents.visible = false

    print('milk jug has: %s' % ingredients)

func take_contents():
    contents.visible = false
    frothed_contents.visible = false
    var previous_ingredients = ingredients
    ingredients = IngredientList.new()
    print('milk jug has: %s' % ingredients)
    return previous_ingredients

func has_contents():
    return not ingredients.is_empty()

func put_back(frother):
    frother.place_milk_jug(self)

func put_down():
    super()
    contents.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
    frothed_contents.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
    contents.render_priority -= 10
    frothed_contents.render_priority -= 10

func pick_up():
    super()
    contents.billboard = BaseMaterial3D.BILLBOARD_ENABLED
    frothed_contents.billboard = BaseMaterial3D.BILLBOARD_ENABLED
    contents.render_priority += 10
    frothed_contents.render_priority += 10
