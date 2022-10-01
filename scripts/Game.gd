extends Node

const Machine = preload("res://scripts/Machine.gd")
const DrinkOrder = preload("res://scripts/DrinkOrder.gd")

const drink_sizes = ["S","M","L"]

@onready var character = $Character

@export var customer_scene: PackedScene

var rng = RandomNumberGenerator.new()
var spawnLocation
var customerCount = 0
var difficulty = 1

var interactables = Array()
var spots = Array()
var ingredients = Array()
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
        if interactable is Machine :
            ingredients.append(interactable.ingredient)

    for spot in get_node("Cafe").get_tree().get_nodes_in_group('CustomerSpots'):
        spots.append(spot)

    print(spots)

func generateDrinkOrder():
    var drinkOrder = DrinkOrder.new()
    drinkOrder.Size = drink_sizes[randi() % drink_sizes.size()]

    for i in range(rng.randi_range(difficulty, difficulty*3)):
            drinkOrder = addIngredient(ingredients[randi() % ingredients.size()],drinkOrder)

    return drinkOrder

func addIngredient(ingredient, drinkOrder: DrinkOrder):
    if(drinkOrder.OrderIngredients.has(ingredient)):
        drinkOrder.OrderIngredients[ingredient] += 1
    else:
        drinkOrder.OrderIngredients[ingredient] = 1

    return drinkOrder

func _on_customer_spawn_timer_timeout():
    if spawnLocation == null:
        spawnLocation = get_node("Cafe/Door")

    var customer = customer_scene.instantiate()
    customer.connect('left', processCustomerLeaving)
    customer.connect('orderDrink', processDrinkOrder)

    var spot = spots.front()
    spots.remove_at(0)

    var order = generateDrinkOrder()
    customer.initialize(spawnLocation.global_transform.origin, spot, order)
    add_child(customer)

func processCustomerLeaving(wasAngry, spotNode):
    spots.append(spotNode)
    customerCount += 1

func processDrinkOrder(drink_order):
    drink_orders.append(drink_order)

