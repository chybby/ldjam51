extends "res://scripts/HoldableItem.gd"

const Milk = preload("res://scripts/Milk.gd")
const MilkJug = preload("res://scripts/MilkJug.gd")

enum CupSize {SMALL, MEDIUM, LARGE}

var ingredients = Array()
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

    var held_item = character.get_held_item()
    if held_item is Milk:
        self.add_ingredient(held_item.ingredient)
    elif held_item is MilkJug:
        self.add_ingredient(held_item.take_contents())
    else:
        super(character, item, interact_position)

    print('%s cup interacted with' % self)

func add_ingredient(ingredient):
    ingredients.append(ingredient)
    print('Cup has ingredients: %s' % ', '.join(ingredients))

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