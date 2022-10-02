extends "res://scripts/Fruit.gd"

const Ingredient = preload("res://scripts/Ingredient.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    ingredient = Ingredient.new(Ingredient.IngredientType.STRAWBERRY, true, false, false)

func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    print('%s strawberry interacted with' % self)
