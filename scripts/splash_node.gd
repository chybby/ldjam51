extends Node3D

func _on_splash_sprite_animation_finished():
    queue_free()
