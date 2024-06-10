extends VideoStreamPlayer

var parameters: Dictionary

@onready var transition = $Transition

func _on_finished():
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
	Functions.load_screen_to_scene("res://scenes/Gameplay/hari_pertama.tscn", {"test": "test"})

func _on_button_pressed():
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
	Functions.load_screen_to_scene("res://scenes/Gameplay/hari_pertama.tscn", {"test": "test"})

func _unhandled_key_input(event):
	if event.is_pressed() or event is InputEventMouseButton:
		transition.play("fade_out")
		await get_tree().create_timer(1).timeout
		Functions.load_screen_to_scene("res://scenes/Gameplay/hari_pertama.tscn", {"test": "test"})
