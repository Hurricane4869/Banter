extends Control

@onready var color_rect = $ColorRect

func _ready():
	color_rect.visible = false

func resume():
	get_tree().paused = false
	color_rect.visible = false
	$AnimationPlayer.play("RESET")

func pause():
	get_tree().paused = true
	color_rect.visible = true
	$AnimationPlayer.play("Handphone")

func testEsc():
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		_on_resume_pressed()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	await get_tree().create_timer(0.8).timeout	
	Functions.restart_scene()
	
func _on_quit_pressed():
	resume()
	await get_tree().create_timer(0.75).timeout		
	Functions.load_screen_to_scene("res://scenes/main menu/main_menu.tscn", {"test": "test"})

func _process(delta):
	testEsc()

