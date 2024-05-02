class_name MainMenu
extends Control

var parameters: Dictionary

@onready var menu = $menu
@onready var play = $menu/HBoxContainer/Play
@onready var keluar = $menu/VBoxContainer/HBoxContainer/Keluar
@onready var start_level = preload("res://scenes/dummy/testing/testing_interaction.tscn") as PackedScene
@onready var back_from_kredit = $Kredit_Panel/BackFromKredit as Button
@onready var transition = $Transition
@onready var pengaturan_text = $menu/HBoxContainer/Pengaturan/Pengaturan_Text
@onready var click_sound = $menu/click_sound
@onready var main_text = $menu/HBoxContainer/Play/Main_Text

func _input (event):
	if event.is_action_pressed("ui_cancel"):
		click_sound.play()
		await click_sound.finished
		get_tree().quit()

func show_and_hide(first, second):
	first.show()
	second.hide()

func _ready():
	print(parameters)
	pengaturan_text.visible = false
	main_text.visible = false
	play.button_down.connect(on_start_pressed)

func on_start_pressed() -> void:
	click_sound.play()
	await click_sound.finished
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
	Functions.load_screen_to_scene("res://scenes/dummy/testing/testing_interaction.tscn", {"test": "test"})

func _on_pengaturan_mouse_entered():
	pengaturan_text.visible = true

func _on_pengaturan_mouse_exited():
	pengaturan_text.visible = false

func _on_play_mouse_entered():
	main_text.visible = true

func _on_play_mouse_exited():
	main_text.visible = false
