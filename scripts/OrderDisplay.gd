extends Control

const DrinkOrder = preload("res://scripts/DrinkOrder.gd")

const OrderDisplayLine = preload("res://scenes/OrderDisplayLine.tscn")

@onready var bar : ProgressBar = %PatienceMeter
@onready var lines = $Panel/MarginContainer/MarginContainer/VBoxContainer/Lines
@onready var cup_size = $Panel/Panel/MarginContainer/MarginContainer/VBoxContainer/CupSize

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

func display_order(order: DrinkOrder):
    #var order_cup_size = order.get_cup_size()
    var ingredient_counts = order.get_ingredients()

    #TODO: change cup_size icon

    for ingredient_count in ingredient_counts:
        var ingredient = ingredient_count[0]
        var count = ingredient_count[1]

        var line = OrderDisplayLine.instantiate()

        lines.add_child(line)

        line.set_count(count)
        line.set_ingredient(ingredient)

func set_patience(current, max_value):
    bar.max_value = max_value
    bar.value = current