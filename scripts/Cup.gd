extends "res://scripts/HoldableItem.gd"

var ingredients = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
    if $Model.mesh != null:
        shader_material = $Model.mesh.material.next_pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

<<<<<<< Updated upstream
func on_interact(item, held_item, interact_position):
    if item != self:
        return

    super(item, held_item, position)

=======
func on_interact(item, holdable_item):
    if item != self:
        return

>>>>>>> Stashed changes
    print('%s cup interacted with' % self)

func add_ingredient(ingredient):
    ingredients.append(ingredient)
    print('Cup has ingredients: %s' % ', '.join(ingredients))
