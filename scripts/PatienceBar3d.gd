extends Sprite3D

@onready var bar : ProgressBar = $SubViewport/ProgressBar
@onready var timer = $PatienceTimer

var hasRunOut = false
var hasStarted = false

func _process(delta):
    bar.max_value = timer.wait_time
    bar.value = timer.time_left
