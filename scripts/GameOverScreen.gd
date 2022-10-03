extends Control

@onready var c_label = $CustomerLabel
@onready var s_label = $ScoreLabel

func update(total_score, customers_served):
    c_label.text = 'You served %d customers.' % customers_served
    s_label = 'and got a score of: %d' % total_score

func _on_button_pressed():
    get_tree().reload_current_scene()
