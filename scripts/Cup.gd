extends "res://scripts/HoldableItem.gd"

const IngredientList = preload("res://scripts/IngredientList.gd")
const Milk = preload("res://scripts/Milk.gd")
const WhippedCream = preload("res://scripts/WhippedCream.gd")
const MilkJug = preload("res://scripts/MilkJug.gd")
const BlenderJug = preload("res://scripts/BlenderJug.gd")

enum CupSize {SMALL, MEDIUM, LARGE}

var ingredients = IngredientList.new()
var size = CupSize.MEDIUM

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

    print('%s cup interacted with' % self)

    var held_item = character.get_held_item()
    if held_item is Milk or held_item is WhippedCream:
        self.add_ingredient(held_item.ingredient.clone())
    elif (held_item is MilkJug or held_item is BlenderJug) and held_item.has_contents():
        # TODO: don't let unblended ingredients go into the cup - tooltip or something
        ingredients.combine(held_item.take_contents())
        print('Cup has ingredients: %s' % ingredients)
    else:
        hold_or_swap(character)

func add_ingredient(ingredient):
    ingredients.add_ingredient(ingredient)
    print('Cup has ingredients: %s' % ingredients)

func get_size():
    return size

func set_size(size):
    self.size = size

    var child_scale
    match size:
        CupSize.SMALL:
            child_scale = 0.6
        CupSize.MEDIUM:
            child_scale = 1
        CupSize.LARGE:
            child_scale = 1.4
    $Model.scale = Vector3.ONE * child_scale
    $Model.position *= child_scale
    $Collision.scale = Vector3.ONE * child_scale
    $Collision.position *= child_scale
