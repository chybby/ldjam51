extends GPUParticles3D

func enable():
    $Timer.start(1)
    visible = true

func _on_timer_timeout():
    visible = false
