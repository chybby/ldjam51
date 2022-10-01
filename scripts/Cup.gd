extends "res://scripts/HoldableItem.gd"

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

    super(character, item, interact_position)

    print('%s cup interacted with' % self)

func add_ingredient(ingredient):
    ingredients.append(ingredient)
    print('Cup has ingredients: %s' % ', '.join(ingredients))

func get_size():
    return size

func set_size(size):
    self.size = size
    match size:
        CupSize.SMALL:
            $Model.scale = Vector3.ONE * 0.6
            $Collision.scale = Vector3.ONE * 0.6
        CupSize.MEDIUM:
            $Model.scale = Vector3.ONE * 1
            $Collision.scale = Vector3.ONE * 1
        CupSize.LARGE:
            $Model.scale = Vector3.ONE * 1.4
            $Collision.scale = Vector3.ONE * 1.4
