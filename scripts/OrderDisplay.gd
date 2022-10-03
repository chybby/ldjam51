extends Control

const Cup = preload("res://scripts/Cup.gd")

const DrinkOrder = preload("res://scripts/DrinkOrder.gd")

const OrderDisplayLine = preload("res://scenes/OrderDisplayLine.tscn")

@onready var bar : ProgressBar = %PatienceMeter
@onready var lines = $Panel/MarginContainer/MarginContainer/VBoxContainer/Lines
@onready var cup_size = $Panel/MarginContainer/MarginContainer/VBoxContainer/CupSize

func display_order(order: DrinkOrder):
    var order_cup_size = order.get_cup_size()
    var ingredient_counts = order.get_ingredients()

    var image = Image.load_from_file(get_cup_icon_path(order_cup_size))
    var texture = ImageTexture.create_from_image(image)
    cup_size.texture = texture

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

func get_cup_icon_path(order_cup_size):
    match order_cup_size:
        Cup.CupSize.SMALL: return 'res://assets/smallcup.png'
        Cup.CupSize.MEDIUM: return 'res://assets/mediumcup.png'
        Cup.CupSize.LARGE: return 'res://assets/largecup.png'
