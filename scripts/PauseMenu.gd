extends Control

@onready var color_rect = $ColorRect
@onready var restart_text = $Handphone/PausePanel/HBoxContainer/VBoxContainer2/Restart/Restart_Text
@onready var misi_text = $Handphone/PausePanel/HBoxContainer/VBoxContainer2/Quests/Misi_Text
@onready var pengaturan_text = $Handphone/PausePanel/HBoxContainer/VBoxContainer/Settings/Pengaturan_Text
@onready var keluar_text = $Handphone/PausePanel/HBoxContainer/VBoxContainer/Quit/Keluar_Text
@onready var resume_text = $Handphone/PausePanel/Resume/Resume_Text
@onready var open_handphone = $open_handphone
@onready var settings_panel = $Handphone/Settings_Panel
@onready var pause_panel = $Handphone/PausePanel
@onready var back_from_settings = $Handphone/Settings_Panel/Back_From_Settings
@onready var sound_panel = $Handphone/Sound_Panel
@onready var video_panel = $Handphone/Video_Panel
@onready var kontrol_panel = $Handphone/Kontrol_Panel
@onready var task_panel = $Handphone/Task_Panel
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var music_BUS_ID = AudioServer.get_bus_index("Music")
@onready var master_BUS_ID = AudioServer.get_bus_index("Master")
@onready var full_screen_check_box = $Handphone/Video_Panel/Video_Settings/Fullscreen/FullScreenCheckBox
@onready var button_hp_audio = $button_hp_audio
@onready var task_level_1 = $Handphone/Task_Panel/Task_Level_1
@onready var task_level_2 = $Handphone/Task_Panel/Task_Level_2
@onready var task_level_3 = $Handphone/Task_Panel/Task_Level_3
@onready var task_level_4 = $Handphone/Task_Panel/Task_Level_4
@onready var task_level_5 = $Handphone/Task_Panel/Task_Level_5

@export var main_menu_scene: PackedScene

var current_level: int = 0

func _ready():
	color_rect.visible = false
	restart_text.visible = false
	misi_text.visible = false
	resume_text.visible = false
	pengaturan_text.visible = false
	keluar_text.visible = false
	settings_panel.visible = false
	sound_panel.visible = false
	video_panel.visible = false
	kontrol_panel.visible = false
	task_panel.visible = false
	full_screen_check_box.set_pressed(true)
	
func resume():
	get_tree().paused = false
	color_rect.visible = false
	$AnimationPlayer.play("RESET")
	open_handphone.play()
	await open_handphone.finished

func pause():
	get_tree().paused = true
	color_rect.visible = true
	$AnimationPlayer.play("Handphone")
	open_handphone.play()
	await open_handphone.finished
	update_tasks()

func _input(event):
	if Input.is_action_just_pressed("esc") and !get_tree().paused and GameStarted.game_started == true:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused and GameStarted.game_started == true:
		resume()

func _on_resume_pressed():
	resume()

func _on_restart_pressed():
	resume()
	await get_tree().create_timer(0.8).timeout   
	Functions.restart_scene() # Hapus upaya mengatur 'parameters'

func _on_quit_pressed():
	resume()
	await get_tree().create_timer(0.75).timeout      
	Functions.load_screen_to_scene("res://scenes/main menu/main_menu.tscn", {"test": "test"})

func _on_restart_mouse_entered():
	restart_text.visible = true
	
func _on_restart_mouse_exited():
	restart_text.visible = false

func _on_quests_pressed():
	task_panel.visible = true
	pause_panel.visible = false
	button_hp_audio.play()
	
func _on_quests_mouse_entered():
	misi_text.visible = true

func _on_quests_mouse_exited():
	misi_text.visible = false

func _on_settings_mouse_entered():
	pengaturan_text.visible = true

func _on_settings_mouse_exited():
	pengaturan_text.visible = false

func _on_quit_mouse_entered():
	keluar_text.visible = true

func _on_quit_mouse_exited():
	keluar_text.visible = false

func _on_resume_mouse_entered():
	resume_text.visible = true

func _on_resume_mouse_exited():
	resume_text.visible = false

func _on_settings_pressed():
	settings_panel.visible = true
	pause_panel.visible = false
	button_hp_audio.play()

func _on_back_from_settings_pressed():
	settings_panel.visible = false
	pause_panel.visible = true
	button_hp_audio.play()

func _on_suara_button_pressed():
	sound_panel.visible = true
	settings_panel.visible = false
	button_hp_audio.play()

func _on_video_button_pressed():
	video_panel.visible = true
	settings_panel.visible = false
	button_hp_audio.play()

func _on_kontrol_button_pressed():
	kontrol_panel.visible = true
	settings_panel.visible = false
	button_hp_audio.play()

func _on_back_from_sound_pressed():
	sound_panel.visible = false
	settings_panel.visible = true
	button_hp_audio.play()

func _on_back_from_video_pressed():
	video_panel.visible = false
	settings_panel.visible = true
	button_hp_audio.play()

func _on_back_from_kontrol_pressed():
	kontrol_panel.visible = false
	settings_panel.visible = true
	button_hp_audio.play()

func _on_back_from_misi_pressed():
	task_panel.visible = false
	pause_panel.visible = true
	button_hp_audio.play()

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

func update_tasks():
	task_level_1.visible = current_level == 1
	task_level_2.visible = current_level == 2
	task_level_3.visible = current_level == 3
	task_level_4.visible = current_level == 4
	task_level_5.visible = current_level == 5
