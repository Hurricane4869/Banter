extends Node

func load_screen_to_scene(target: String, parameters: Dictionary = {}) -> void:
	var loading_screen = preload("res://scenes/main menu/LoadingScreen.tscn").instantiate()
	loading_screen.next_scene_path = target
	loading_screen.parameters = parameters
	get_tree().current_scene.add_child(loading_screen)

func restart_scene():
	var loading_screen = preload("res://scenes/main menu/LoadingScreen.tscn").instantiate()
	get_tree().current_scene.add_child(loading_screen)
	await get_tree().create_timer(0.8).timeout
	get_tree().reload_current_scene()

