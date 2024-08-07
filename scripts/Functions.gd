extends Node

func load_screen_to_scene(target: String, parameters: Dictionary = {}) -> void:
	var loading_screen = preload("res://scenes/main menu/LoadingScreen.tscn").instantiate()
	loading_screen.next_scene_path = target
	loading_screen.parameters = parameters
	get_tree().current_scene.add_child(loading_screen)

func restart_scene():
	var current_scene = get_tree().current_scene
	var loading_screen = preload("res://scenes/main menu/LoadingScreen.tscn").instantiate()
	loading_screen.next_scene_path = current_scene.scene_file_path
	current_scene.add_child(loading_screen)
