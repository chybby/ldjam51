extends Node

@export var customer_scene: PackedScene

var spawnLocation

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_customer_spawn_timer_timeout():
	if spawnLocation == null:
		spawnLocation = get_node("Cafe/Door")
			
	print(spawnLocation.global_transform.origin)
	
	var customer = customer_scene.instantiate()
	customer.initialize(spawnLocation.global_transform.origin)	
	
	add_child(customer)
