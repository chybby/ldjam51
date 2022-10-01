extends CanvasLayer

@onready var fps_counter : Label = $FpsCounter

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var fps = 1/delta
    fps_counter.text = "%.0f" % fps
