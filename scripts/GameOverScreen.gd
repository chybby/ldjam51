extends Control

@onready var label = $Label

func update(customers_served):
    label.text = 'You served %d customers.' % customers_served


func _on_button_pressed():
    get_tree().reload_current_scene()
