extends Node2D

@onready var interaction_area: InteractionArea = $Environment/AntarPaket
@onready var play_button = $UI/PlayDummy
@onready var timer = $UI/QuestTimer
@onready var pause_button = $UI/Pause
@onready var pause_text = $UI/Pause/Pause_Text
@onready var pause_menu = $UI/PauseMenu
@onready var black_overlay = get_node("UI/PauseMenu/ColorRect")
@onready var handphone = $UI/PlayQuest/Handphone
@onready var play_quest = $UI/PlayQuest
@onready var play_text = $UI/PlayQuest/PlayButton/Play_Text
@onready var open_handphone_sound = $open_handphone
@onready var bgm_lvl_1 = $BGM_lvl1
@onready var rating_system = $UI/RatingSystem
@onready var finish_quest_sound = $Finish_quest_sound


@onready var star_0 = $UI/RatingSystem/rating_menu/Star0
@onready var star_1 = $UI/RatingSystem/rating_menu/Star1
@onready var star_2 = $UI/RatingSystem/rating_menu/Star2
@onready var star_3 = $UI/RatingSystem/rating_menu/Star3

var parameters: Dictionary

var status_paket : bool = false

var time_left : int

func _ready():
	#rating_dummy.visible = false
	pause_text.visible = false
	play_text.visible = false
	timer.start() 
	get_tree().paused = true
	handphone.play("Quest_Appear")
	open_handphone_sound.play()
	await open_handphone_sound.finished

func _process(_delta):
	if get_tree().paused == false:
		interaction_area.interact = Callable(self, "_antar_paket")
	pass

func _antar_paket():
	print_debug("Paket Sampai")
	status_paket = true
	timer.set_paused(true)

	time_left = timer.get_time_left()
	_process_rating(time_left)
	
	get_tree().paused = true
	black_overlay.visible = true
	rating_system.visible = true
	finish_quest_sound.play()

func _process_rating(time_left):
	if time_left >= 120:  # More than 2 minutes
		_show_rating(3)
	elif time_left >= 60 and time_left < 120:  # More than 1 minute
		_show_rating(2)
	elif time_left > 0 and time_left < 60:  # More than 0 seconds
		_show_rating(1)
	elif time_left <= 0:  # 0 seconds or less
		get_tree().paused = true
		_show_rating(0)

func _show_rating(rating):
	star_1.visible = rating == 1
	star_2.visible = rating == 2
	star_3.visible = rating == 3

func _on_pause_pressed():
	pause_menu.pause()

func _on_pause_mouse_entered():
	pause_text.visible = true

func _on_pause_mouse_exited():
	pause_text.visible = false

func _on_play_button_pressed():
	handphone.play_backwards("Start_Quest")
	get_tree().paused = false
	open_handphone_sound.play()
	await open_handphone_sound.finished
	bgm_lvl_1.play()

func _on_play_button_mouse_entered():
	play_text.visible = true

func _on_play_button_mouse_exited():
	play_text.visible = false

func _on_chooselevel_button_pressed():
	get_tree().paused = false
	Functions.load_screen_to_scene("res://scenes/main menu/main_menu.tscn", {"test": "test"})

func _on_restart_button_pressed():
	get_tree().paused = false
	Functions.restart_scene() # Hapus upaya mengatur 'parameters'

func _on_next_level_button_pressed():
	get_tree().paused = false
	Functions.load_screen_to_scene("res://scenes/dummy/level_2.tscn", {"test": "test"})


func _on_quest_timer_timeout():
	get_tree().paused = true
	star_0.visible = true
	black_overlay.visible = true
	rating_system.visible = true
