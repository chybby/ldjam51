extends "res://scripts/HoldableItem.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func on_interact(item, holdable_item):
    if item != self:
        return

    print('%s cup interacted with' % self)
