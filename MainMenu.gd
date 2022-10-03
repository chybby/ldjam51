extends Control

@onready var game_scene = get_parent()
var difficulty = 2

func _ready():
    Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_start_pressed():
    visible = false
    game_scene.start_game(difficulty)

func _on_settings_pressed():
    visible = false
    %SettingsScreen.OpenFromMainMenu()

func _on_easy_pressed():
    difficulty = 1

func _on_normal_pressed():
    difficulty = 2

func _on_barista_pressed():
    difficulty = 4
    print('we barista up in this bitch')

func _on_quit_pressed():
    get_tree().quit()
