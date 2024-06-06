class_name MainMenu
extends Control

var parameters: Dictionary

@onready var menu = $menu
@onready var play = $menu/HBoxContainer/Play
@onready var transition = $Transition
@onready var pengaturan_text = $menu/HBoxContainer/Pengaturan/Pengaturan_Text
@onready var click_sound = $menu/click_sound
@onready var main_text = $menu/HBoxContainer/Play/Main_Text
@onready var quit_panel = $Quit_Panel
@onready var quit_temenan = $"Quit_Panel/Quit_Menu/HBoxContainer/Quit temenan"
@onready var back_from_quit = $Quit_Panel/Quit_Menu/HBoxContainer/BackFromQuit
@onready var bgm = $BGM
@onready var settings_panel = $Settings_Panel
@onready var suara_button = $Settings_Panel/Settings_Menu/HBoxContainer/Settings_Button/Suara_Button
@onready var video_button = $Settings_Panel/Settings_Menu/HBoxContainer/Settings_Button/Video_Button
@onready var kontrol_button = $Settings_Panel/Settings_Menu/HBoxContainer/Settings_Button/Kontrol_Button
@onready var sound_panel = $Sound_Panel
@onready var video_panel = $Video_Panel
@onready var kontrol_panel = $Kontrol_Panel
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var music_BUS_ID = AudioServer.get_bus_index("Music")
@onready var master_BUS_ID = AudioServer.get_bus_index("Master")
@onready var full_screen_check_box = $Video_Panel/Video_Settings/Fullscreen/FullScreenCheckBox
@onready var choose_level_panel = $ChooseLevel_Panel
@onready var level_1 = $ChooseLevel_Panel/VBoxContainer/HBoxContainer/Level1
@onready var levels = $ChooseLevel_Panel/Levels_VBoxCOntainer/Levels
@onready var cutscene_prolog = $CutsceneProlog

func _input (event):
	if event.is_action_pressed("ui_cancel"):
		click_sound.play()
		await click_sound.finished
		quit_panel.visible = true

func show_and_hide(first, second):
	first.show()
	second.hide()

func _ready():
	print(parameters)
	play.button_down.connect(_on_play_pressed)
	quit_panel.visible = false
	bgm.play()
	full_screen_check_box.set_pressed(true)

func change_level(lvl_no):
	Functions.load_screen_to_scene("res://scenes/dummy/level_" + lvl_no + ".tscn")
	
func _on_quit_temenan_pressed():
	click_sound.play()
	await click_sound.finished
	get_tree().quit()

func _on_back_from_quit_pressed():
	click_sound.play()
	await click_sound.finished
	quit_panel.visible = false

func _on_pengaturan_pressed():
	click_sound.play()
	menu.visible = false
	settings_panel.visible = true
	

func _on_play_pressed():
	click_sound.play()
	menu.visible = false
	choose_level_panel.visible = true
	

func _on_back_from_settings_pressed():
	click_sound.play()
	settings_panel.visible = false
	menu.visible = true

func _on_suara_button_pressed():
	click_sound.play()
	sound_panel.visible = true
	settings_panel.visible = false

func _on_video_button_pressed():
	click_sound.play()
	video_panel.visible = true
	settings_panel.visible = false

func _on_kontrol_button_pressed():
	click_sound.play()
	kontrol_panel.visible = true
	settings_panel.visible = false

func _on_back_from_sound_pressed():
	click_sound.play()
	sound_panel.visible = false
	settings_panel.visible = true

func _on_back_from_video_pressed():
	click_sound.play()
	video_panel.visible = false
	settings_panel.visible = true

func _on_back_from_kontrol_pressed():
	click_sound.play()
	kontrol_panel.visible = false
	settings_panel.visible = true

func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(music_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(music_BUS_ID, value < .05)

func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(master_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(master_BUS_ID, value < .05)

func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, linear_to_db(value))
	AudioServer.set_bus_mute(SFX_BUS_ID, value < .05)

func _on_full_screen_check_box_toggled(toggled_on):
	if toggled_on:
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_back_from_level_pressed():
	click_sound.play()
	choose_level_panel.visible = false
	menu.visible = true

func _on_level_1_pressed():
	click_sound.play()
	await click_sound.finished
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
	Functions.load_screen_to_scene("res://scenes/cutscene_prolog.tscn", {"test": "test"})

func _on_level_2_pressed():
	click_sound.play()
	await click_sound.finished
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
	Functions.load_screen_to_scene("res://scenes/Gameplay/hari_kedua.tscn", {"test": "test"})

func _on_level_3_pressed():
	click_sound.play()
	await click_sound.finished
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
	Functions.load_screen_to_scene("res://scenes/Gameplay/hari_ketiga.tscn", {"test": "test"})

func _on_level_4_pressed():
	click_sound.play()
	await click_sound.finished
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
	Functions.load_screen_to_scene("res://scenes/Gameplay/hari_keempat.tscn", {"test": "test"})

func _on_level_5_pressed():
	click_sound.play()
	await click_sound.finished
	transition.play("fade_out")
	await get_tree().create_timer(1).timeout
	Functions.load_screen_to_scene("res://scenes/Gameplay/hari_kelima.tscn", {"test": "test"})
