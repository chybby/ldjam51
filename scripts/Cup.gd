extends "res://scripts/HoldableItem.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func on_interact(item, held_item):
    if item != self:
        return

    super(item, held_item)

    print('%s cup interacted with' % self)