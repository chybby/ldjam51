extends Node

const CupDispenser = preload("res://scripts/CupDispenser.gd")
const RubbishBin = preload("res://scripts/RubbishBin.gd")
const EspressoMachine = preload("res://scripts/EspressoMachine.gd")
const Fridge = preload("res://scripts/Fridge.gd")
const Surface = preload("res://scripts/Surface.gd")
const Machine = preload("res://scripts/Machine.gd")
const Cup = preload("res://scripts/Cup.gd")
const Milk = preload("res://scripts/Milk.gd")
const Fruit = preload("res://scripts/Fruit.gd")
const WhippedCream = preload("res://scripts/WhippedCream.gd")
const DrinkOrderMaker = preload("res://scripts/DrinkOrderMaker.gd")

@onready var character = $Character

@export var customer_scene: PackedScene

@onready var spawnLocation = $Cafe/Door
var customerCount = 0
var difficulty = 1

var interactables = Array()

var spots = Array()

var drink_order_maker = DrinkOrderMaker.new()

# TODO: Stop spawning customers when the morning is over. Stop the morning when the last customer leaves.
# TODO: Each morning:
#   - Add some new machine (some kind of screen showing what was added?)
#   - In addition to new ingredients, make orders a little more complicated (more ingredients per order, higher counts per ingredient).
#   - Clean up any yeeted things on the floor

# TODO: should the morning bar be a digital clock that goes from 8am to 10am? 10am = survived the morning.

# TODO: title screen + options (volume, mouse sensitivity, fullscreen?)

#TODO: customers can get stuck on thrown drinks

# Called when the node enters the scene tree for the first time.
func _ready():
    for interactable in get_tree().get_nodes_in_group('interactable'):
        #TODO: uncomment
        # if not (interactable is EspressoMachine or interactable is CupDispenser or interactable is Fridge or interactable is RubbishBin or interactable is Surface):
        #     remove_child(interactable)

        # if interactable is CupDispenser and interactable.cup_size != Cup.CupSize.MEDIUM:
        #     remove_child(interactable)

        interactables.append(interactable)

    for interactable in interactables:
        if interactable.get_parent() == null:
            continue

        character.connect('focus_changed', interactable.on_focus_changed)
        character.connect('interacted_with', interactable.on_interact)

        if interactable is Machine:
            drink_order_maker.add_available_ingredient(interactable.ingredient)
        elif interactable is Milk:
            drink_order_maker.add_available_ingredient(interactable.ingredient)
        elif interactable is Fruit:
            drink_order_maker.add_available_ingredient(interactable.ingredient)
        elif interactable is WhippedCream:
            drink_order_maker.add_available_ingredient(interactable.ingredient)
        elif interactable is CupDispenser:
            drink_order_maker.add_available_cup_size(interactable.cup_size)

    print(drink_order_maker.available_ingredients)

    for spot in get_node("Cafe").get_tree().get_nodes_in_group('CustomerSpots'):
        spots.append(spot)

    print(spots)

    # TODO: remove, only for debugging
    spawn_customer()

func _on_customer_spawn_timer_timeout():
    spawn_customer()

func spawn_customer():
    var customer = customer_scene.instantiate()
    customer.connect('left', processCustomerLeaving)

    var spot = spots.front()
    spots.remove_at(0)

    var order = drink_order_maker.generate_order()
    print('customer\'s order is %s' % order)
    add_child(customer)
    customer.initialize(spawnLocation.global_transform.origin, spot, order)


func processCustomerLeaving(_wasAngry, spotNode):
    spots.append(spotNode)
    customerCount += 1
