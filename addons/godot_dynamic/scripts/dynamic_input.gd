extends Node


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("f11"):
		toggle_fullscreen()


func toggle_fullscreen() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
