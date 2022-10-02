extends Node

const Machine = preload("res://scripts/Machine.gd")
const DrinkOrderMaker = preload("res://scripts/DrinkOrderMaker.gd")

@onready var character = $Character

@export var customer_scene: PackedScene

var spawnLocation
var customerCount = 0
var difficulty = 1

var interactables = Array()
var spots = Array()

var drink_order_maker = DrinkOrderMaker.new()

var drink_orders = Array()

# Called when the node enters the scene tree for the first time.
func _ready():
    for interactable in get_tree().get_nodes_in_group('interactable'):
        interactables.append(interactable)

    print(interactables)

    for interactable in interactables:
        # TODO: do this whenever an interactable is added.
        character.connect('focus_changed', interactable.on_focus_changed)
        character.connect('interacted_with', interactable.on_interact)
        if interactable is Machine:
            # TODO: add ingredients from other sources (eg. milk, fruit)
            drink_order_maker.add_available_ingredient(interactable.ingredient)

    for spot in get_node("Cafe").get_tree().get_nodes_in_group('CustomerSpots'):
        spots.append(spot)

    print(spots)

func _on_customer_spawn_timer_timeout():
    if spawnLocation == null:
        spawnLocation = get_node("Cafe/Door")

    var customer = customer_scene.instantiate()
    customer.connect('left', processCustomerLeaving)
    customer.connect('orderDrink', processDrinkOrder)

    var spot = spots.front()
    spots.remove_at(0)

    var order = drink_order_maker.generate_order()
    print('customer\'s order is %s' % order)
    add_child(customer)
    customer.initialize(spawnLocation.global_transform.origin, spot, order)


func processCustomerLeaving(wasAngry, spotNode):
    spots.append(spotNode)
    customerCount += 1

func processDrinkOrder(drink_order):
    drink_orders.append(drink_order)
