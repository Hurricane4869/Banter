class_name MainMenu2
extends Control

@onready var menu = $menu
@onready var play = $menu/VBoxContainer/Play as Button
@onready var keluar = $menu/VBoxContainer/Keluar as Button
@onready var kredit = $menu/VBoxContainer/Kredit as Button
@onready var kredit_panel = $Kredit_Panel
@onready var start_level = preload("res://scenes/dummy/level_prototype.tscn") as PackedScene
@onready var back_from_kredit = $Kredit_Panel/BackFromKredit as Button
@onready var transition = $Transition

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
	focus_button()
	play.button_down.connect(on_start_pressed)
	keluar.button_down.connect(on_exit_pressed)
	kredit.button_down.connect(on_kredit_pressed)
	back_from_kredit.button_down.connect(_on_BackFromKredit_pressed)

func on_start_pressed() -> void:
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
	_on_transition_animation_finished("fade_out")
	
func _on_transition_animation_finished(anim_name):
	get_tree().change_scene_to_packed(start_level)

func on_exit_pressed() -> void:
	get_tree().quit()
	
func on_kredit_pressed() -> void:
	show_and_hide(kredit_panel, menu)

func _on_BackFromKredit_pressed():
	show_and_hide(menu, kredit_panel)
	
func focus_button() -> void:
	if play :
		var button : Button = play.get_child(0)
		if button is Button:
			button.grab_focus()
