class_name MainMenu
extends Control

@onready var play = $HBoxContainer/VBoxContainer/Play as Button
@onready var keluar = $HBoxContainer/VBoxContainer/Keluar as Button
@onready var start_level = preload("res://scenes/dummy/testing/testing_interaction.tscn") as PackedScene

func _ready():
	play.button_down.connect(on_start_pressed)
	keluar.button_down.connect(on_exit_pressed)

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_exit_pressed() -> void:
	get_tree().quit()
