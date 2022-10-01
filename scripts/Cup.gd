extends "res://scripts/HoldableItem.gd"

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

    super(character, item, interact_position)

    print('%s cup interacted with' % self)

func add_ingredient(ingredient):
    ingredients.append(ingredient)
    print('Cup has ingredients: %s' % ', '.join(ingredients))
