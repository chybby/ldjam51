extends "res://scripts/Milk.gd"

const Ingredient = preload("res://scripts/Ingredient.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    ingredient = Ingredient.new(Ingredient.IngredientType.SOY_MILK, false, true, false)

func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    print('%s soy milk interacted with' % self)
