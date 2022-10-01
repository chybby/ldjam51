extends Node

@onready var character = $Character

@export var customer_scene: PackedScene

var spawnLocation
var noOfCustomers

var interactables = Array()
var spots = Array()
var customerSpot = Array()


# Called when the node enters the scene tree for the first time.
func _ready():
    for interactable in get_tree().get_nodes_in_group('interactable'):
        interactables.append(interactable)

    print(interactables)

    for interactable in interactables:
        character.connect('focus_changed', interactable.on_focus_changed)
        character.connect('interacted_with', interactable.on_interact)
        
    for spot in get_node("Cafe").get_tree().get_nodes_in_group('CustomerSpots'):
        spots.append(spot)
        
    print(spots)


func _on_customer_spawn_timer_timeout():
    if spawnLocation == null:
        spawnLocation = get_node("Cafe/Door")

    var customer = customer_scene.instantiate()
    
    var spot = spots.front()
    spots.remove_at(0)

    customer.initialize(spawnLocation.global_transform.origin, spot)	
    
    add_child(customer)
    customerSpot.append(spot)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    pass

func processCustomerLeaving(wasAngry):
    pass

func _on_customer_left(angry, spot):
    spots.append(spot)
