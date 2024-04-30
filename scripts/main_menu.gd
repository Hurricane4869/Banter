class_name MainMenu
extends Control

var parameters: Dictionary

@onready var menu = $menu
@onready var play = $menu/VBoxContainer/Play as Button
@onready var keluar = $menu/VBoxContainer/HBoxContainer/Keluar
@onready var start_level = preload("res://scenes/dummy/testing/testing_interaction.tscn") as PackedScene
@onready var back_from_kredit = $Kredit_Panel/BackFromKredit as Button
@onready var transition = $Transition
@onready var keluar_text = $menu/VBoxContainer/HBoxContainer/Keluar/Keluar_Text
@onready var pengaturan_text = $menu/VBoxContainer/HBoxContainer/Pengaturan/Pengaturan_Text
@onready var audio_player = $menu/click



#func _process(delta):
	#if Input.is_action_just_pressed("ui_cancel"):
		#toggle()

func show_and_hide(first, second):
	first.show()
	second.hide()

func _ready():
	print(parameters)
	keluar_text.visible = false
	pengaturan_text.visible = false
	play.button_down.connect(on_start_pressed)
	keluar.button_down.connect(on_exit_pressed)

func on_start_pressed() -> void:
	audio_player.play()
	await audio_player.finished
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
	Functions.load_screen_to_scene("res://scenes/dummy/testing/testing_interaction.tscn", {"test": "test"})

func on_exit_pressed() -> void:
	audio_player.play()
	await audio_player.finished
	get_tree().quit()


func _on_keluar_mouse_entered():
	keluar_text.visible = true
	
func _on_keluar_mouse_exited():
	keluar_text.visible = false

func _on_pengaturan_mouse_entered():
	pengaturan_text.visible = true

func _on_pengaturan_mouse_exited():
	pengaturan_text.visible = false

