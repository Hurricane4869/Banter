class_name MainMenu
extends Control

@onready var menu = $menu
@onready var play = $menu/VBoxContainer/Play as Button
@onready var keluar = $menu/VBoxContainer/Keluar as Button
@onready var kredit = $menu/VBoxContainer/Kredit as Button
@onready var kredit_panel = $Kredit_Panel
@onready var start_level = preload("res://scenes/dummy/testing/testing_interaction.tscn") as PackedScene
@onready var back_from_kredit = $Kredit_Panel/BackFromKredit as Button

#func _process(delta):
	#if Input.is_action_just_pressed("ui_cancel"):
		#toggle()

func toggle():
	visible = !visible
	get_tree().paused = visible

func show_and_hide(first, second):
	first.show()
	second.hide()

func _ready():
	play.button_down.connect(on_start_pressed)
	keluar.button_down.connect(on_exit_pressed)
	kredit.button_down.connect(on_kredit_pressed)
	back_from_kredit.button_down.connect(_on_BackFromKredit_pressed)

func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_exit_pressed() -> void:
	get_tree().quit()
	
func on_kredit_pressed() -> void:
	show_and_hide(kredit_panel, menu)

func _on_BackFromKredit_pressed():
	show_and_hide(menu, kredit_panel)
