extends "res://scripts/Machine.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func on_interact(item, held_item):
    if item != self:
        return

    print('%s espresso machine interacted with' % self)
