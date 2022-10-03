extends CanvasLayer

@onready var fps_counter : Label = $FpsCounter
@onready var clock : Label = $Clock
@onready var clock_blink_timer : Timer = $ClockBlink


func update_time(time_left, max_time):
    var time_elapsed = max_time - time_left
    var hour = 8
    var minute = 0

    while time_elapsed >= 60:
        hour += 1
        time_elapsed -= 60

    minute = time_elapsed

    clock.text = "%02d:%02d AM" % [hour, minute]

    if time_left == 0:
        if clock_blink_timer.is_stopped():
            clock_blink_timer.start()
    else:
        clock_blink_timer.stop()
        clock.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var fps = 1/delta
    fps_counter.text = "%.0f" % fps


func _on_clock_blink_timeout():
    clock.visible = not clock.visible
