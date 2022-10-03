extends "res://scripts/Fruit.gd"

const Ingredient = preload("res://scripts/Ingredient.gd")


func _init():
    ingredient = Ingredient.new(Ingredient.IngredientType.STRAWBERRY, true, false, false)
    item_name = "Strawberry"

# Called when the node enters the scene tree for the first time.
func _ready():
    super()
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    print('%s strawberry interacted with' % self)
