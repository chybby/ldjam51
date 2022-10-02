extends "res://scripts/Machine.gd"

const Ingredient = preload("res://scripts/Ingredient.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass

    ingredient = Ingredient.new(Ingredient.IngredientType.ESPRESSO_SHOT, false, false, false)


func on_interact(character, item, interact_position):
    if item != self:
        return

    super(character, item, interact_position)

    print('%s espresso machine interacted with' % self)
