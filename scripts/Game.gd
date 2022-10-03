extends Node

const BlenderJug = preload("res://scripts/BlenderJug.gd")
const CupDispenser = preload("res://scripts/CupDispenser.gd")
const RubbishBin = preload("res://scripts/RubbishBin.gd")
const EspressoMachine = preload("res://scripts/EspressoMachine.gd")
const Fridge = preload("res://scripts/Fridge.gd")
const FridgeDoor = preload("res://scripts/FridgeDoor.gd")
const Surface = preload("res://scripts/Surface.gd")
const Machine = preload("res://scripts/Machine.gd")
const Cup = preload("res://scripts/Cup.gd")
const Milk = preload("res://scripts/Milk.gd")
const MilkJug = preload("res://scripts/MilkJug.gd")
const Fruit = preload("res://scripts/Fruit.gd")
const WhippedCream = preload("res://scripts/WhippedCream.gd")
const DrinkOrderMaker = preload("res://scripts/DrinkOrderMaker.gd")
const HoldableItem = preload("res://scripts/HoldableItem.gd")
const Blender = preload("res://scripts/Blender.gd")
const Mango = preload("res://scripts/Mango.gd")
const FruitCrate = preload("res://scripts/FruitCrate.gd")
const MilkFrother = preload("res://scripts/MilkFrother.gd")

signal game_was_paused(paused)

@onready var character = $Character

@export var customer_scene: PackedScene
@onready var customer_spawn_timer : Timer = $CustomerSpawnTimer
@onready var spawnLocation = $Cafe/Door

@onready var morning_timer = $MorningTimer
@onready var hud = $HUD

@onready var new_ingredient_screen = $NewIngredientScreen
@onready var new_machine_screen = $NewMachineScreen
@onready var settings_screen = $SettingsScreen

@onready var hot_water_dispenser = $HotWaterDispenser
@onready var ice_machine = $IceMachine
@onready var caramel_syrup = $CaramelSyrup
@onready var hazelnut_syrup = $HazelnutSyrup
@onready var vanilla_syrup = $VanillaSyrup
@onready var oat_milk = $OatMilk
@onready var soy_milk = $SoyMilk
@onready var whole_milk = $WholeMilk
@onready var skimmed_milk = $SkimmedMilk
@onready var whipped_cream = $WhippedCream
@onready var blender = $Blender
@onready var blender_jug = $Blender/BlenderJug
@onready var milk_frother = $MilkFrother
@onready var milk_jug = $MilkFrother/MilkJug
@onready var small_cup_dispenser = $CupDispenserSmall
@onready var medium_cup_dispenser = $CupDispenserMedium
@onready var large_cup_dispenser = $CupDispenserLarge
@onready var mango_crate = $MangoCrate
@onready var strawberry_crate = $StrawberryCrate
@onready var banana_crate = $BananaCrate


var trashed_items = Array()

var num_customers = 0
var difficulty = 1

var spots = Array()

var drink_order_maker = DrinkOrderMaker.new()

var game_paused = false

var day = 0

# TODO: make orders a little more complicated each day (more ingredients per order, higher counts per ingredient).
# TODO: title screen + options (volume, mouse sensitivity, fullscreen?)

# Called when the node enters the scene tree for the first time.
func _ready():
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

    for interactable in get_tree().get_nodes_in_group('interactable'):
        interactable.set_initial_position()
        if not (interactable is EspressoMachine or interactable is CupDispenser or interactable is Fridge or interactable is FridgeDoor or interactable is RubbishBin or interactable is Surface or interactable is BlenderJug or interactable is MilkJug or interactable is MilkFrother or interactable is Milk or interactable is WhippedCream or interactable is Blender or interactable is FruitCrate):
            disable_interactable(interactable)

        if interactable is CupDispenser and interactable.cup_size != Cup.CupSize.MEDIUM:
            disable_interactable(interactable)

        character.connect('focus_changed', interactable.on_focus_changed)
        character.connect('interacted_with', interactable.on_interact)

        if not interactable.visible:
            continue

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
    #spawn_customer()

func _input(event):
    if game_paused:
        return

    if event.is_action_pressed('game_pause'):
        $HUD/Crosshair.visible = false
        settings_screen.visible = true
        Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
        pause_game()

func trash_item(item):
    add_child(item)
    disable_interactable(item)
    trashed_items.append(item)

func disable_interactable(interactable):
    interactable.visible = false
    interactable.position.y -= 300

func enable_interactable(interactable):
    interactable.visible = true
    interactable.position.y += 300

func _process(_delta):
    if game_paused:
        return

    hud.update_time(morning_timer.time_left, morning_timer.wait_time)

    if num_customers == 0 and morning_timer.is_stopped():
        # End of the morning
        print("Morning rush over!")

        pause_game()

        day += 1
        print("Moving on to day %s" % day)

        hud.visible = false

        var unlocked_machine = unlock_machine(day)

        if unlocked_machine == null:
            var unlocked_ingredient = unlock_ingredient(day)
            if unlocked_ingredient == null:
                #TODO: end the game
                print('game over!')
            else:
                new_ingredient_screen.set_ingredient(unlocked_ingredient)
                new_ingredient_screen.visible = true
        else:
            new_machine_screen.set_machine(unlocked_machine)
            new_machine_screen.visible = true

func unlock_machine(new_day):
    var machine = null
    var ingredient = null
    match new_day:
        1:
            machine = hot_water_dispenser
            ingredient = hot_water_dispenser.ingredient
        2:
            machine = ice_machine
            ingredient = ice_machine.ingredient
        3:
            machine = milk_frother
        4:
            machine = null
        5:
            machine = small_cup_dispenser
            drink_order_maker.add_available_cup_size(Cup.CupSize.SMALL)
        6:
            machine = vanilla_syrup
        7:
            machine = blender
        8:
            machine = null
        9:
            machine = null
        10:
            machine = null
        11:
            machine = large_cup_dispenser
            drink_order_maker.add_available_cup_size(Cup.CupSize.LARGE)
        12:
            machine = caramel_syrup
        13:
            machine = null
        14:
            machine = null
        15:
            machine = hazelnut_syrup
        16:
            machine = null

    if machine != null:
        enable_interactable(machine)

    if ingredient != null:
        drink_order_maker.add_available_ingredient(ingredient)

    return machine

func unlock_ingredient(new_day):
    var interactable = null
    var ingredient = null
    match new_day:
        1:
            interactable = null
        2:
            interactable = null
        3:
            interactable = whole_milk
            ingredient = whole_milk.ingredient
        4:
            interactable = skimmed_milk
            ingredient = skimmed_milk.ingredient
        5:
            interactable = null
        6:
            interactable = null
        7:
            interactable = banana_crate
            ingredient = banana_crate.fruit.instantiate().ingredient
        8:
            interactable = whipped_cream
            ingredient = whipped_cream.ingredient
        9:
            interactable = soy_milk
            ingredient = soy_milk.ingredient
        10:
            interactable = strawberry_crate
            print(strawberry_crate.fruit.instantiate().ingredient)
            ingredient = strawberry_crate.fruit.instantiate().ingredient
        11:
            interactable = null
        12:
            interactable = null
        13:
            interactable = oat_milk
            ingredient = oat_milk.ingredient
        14:
            interactable = mango_crate
            ingredient = mango_crate.fruit.instantiate().ingredient
        15:
            interactable = null
        16:
            interactable = null

    if interactable != null:
        enable_interactable(interactable)

    if ingredient != null:
        drink_order_maker.add_available_ingredient(ingredient)

    return ingredient

func _on_customer_spawn_timer_timeout():
    spawn_customer()

func spawn_customer():
    var customer = customer_scene.instantiate()
    customer.connect('left', processCustomerLeaving)
    connect('game_was_paused', customer.on_game_paused)

    var spot = spots.front()
    spots.remove_at(0)

    var order = drink_order_maker.generate_order(day, difficulty)
    print('customer\'s order is %s' % order)
    add_child(customer)
    $Cafe/Door/SoundDoorbell.play()
    num_customers += 1
    customer.initialize(spawnLocation.global_transform.origin, spot, order)

func processCustomerLeaving(_was_angry, spot_node):
    spots.append(spot_node)
    num_customers -= 1

func reset_game():
    morning_timer.start()
    customer_spawn_timer.start()
    num_customers = 0
    hud.visible = true

    character.reset()

    var held_item = character.release_item()
    add_child(held_item)

    milk_jug.take_contents()
    blender_jug.take_contents()

    for item in trashed_items:
        enable_interactable(item)

    trashed_items.clear()

    for interactable in get_tree().get_nodes_in_group('interactable'):

        if interactable is HoldableItem:
            interactable.rotation = Vector3.ZERO
            interactable.freeze = true
            interactable.set_collision_layer(1)

        if interactable.visible:
            if interactable is Cup or interactable is Fruit:
                interactable.queue_free()
            elif interactable is BlenderJug:
                interactable.put_back(blender)
            elif interactable is MilkJug:
                interactable.put_back(milk_frother)
            elif interactable is Milk or interactable is WhippedCream:
                interactable.call_deferred('reset_position')
            elif interactable is FridgeDoor:
                interactable.close()

    call_deferred('unpause_game')

func _on_morning_timer_timeout():
    customer_spawn_timer.stop()

func _on_new_ingredient_screen_next_screen():
    new_ingredient_screen.visible = false
    reset_game()

func pause_game():
    game_paused = true
    customer_spawn_timer.paused = true
    morning_timer.paused = true
    game_was_paused.emit(true)

func unpause_game():
    customer_spawn_timer.paused = false
    morning_timer.paused = false
    game_paused = false
    game_was_paused.emit(false)

func _on_new_machine_screen_next_screen():
    new_machine_screen.visible = false
    new_machine_screen.unset_machine()
    var unlocked_ingredient = unlock_ingredient(day)
    if unlocked_ingredient == null:
        reset_game()
    else:
        new_ingredient_screen.set_ingredient(unlocked_ingredient)
        new_ingredient_screen.set_deferred('visible', true)

func _on_settings_screen_settings_closed():
    $HUD/Crosshair.visible = true
    settings_screen.visible = false
    print(settings_screen.visible)
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
    call_deferred('unpause_game')
