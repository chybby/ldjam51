extends Control

signal mouse_sensitivity_changed(sense)
signal settings_closed

@onready var main_menu_scene = %MainMenu

var fromMainMenu

func _input(event):
    if not visible:
        return

    if event.is_action_pressed('game_pause'):
        if(fromMainMenu):
            ReturnToMainMenu()
        else:
            settings_closed.emit()
        
func OpenFromMainMenu():
    fromMainMenu = true
    visible = true
    
func ReturnToMainMenu():
    visible = false
    fromMainMenu = false
    main_menu_scene.visible = true

func _on_mouse_sensitivity_slider_value_changed(value:float):
    mouse_sensitivity_changed.emit(value)

func _on_volume_slider_value_changed(value:float):
    AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_return_button_pressed():
    ReturnToMainMenu()
