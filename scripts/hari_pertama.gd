extends Node2D

#Mechanics
@onready var interaction_area: InteractionArea = $Environment/AntarPaket
@onready var timer = $UI/QuestTimer
@onready var character_ali = $Character_Ali
@export var BAD_TIME: int
@export var NORMAL_TIME: int
@export var GOOD_TIME: int

#UI
@onready var play_button = $UI/PlayDummy
@onready var pause_button = $UI/Pause
@onready var pause_text = $UI/Pause/Pause_Text
@onready var pause_menu = $UI/PauseMenu
@onready var black_overlay = get_node("UI/PauseMenu/ColorRect")
@onready var rating_system = $UI/RatingSystem
@onready var handphone = $UI/PlayQuest/Handphone
@onready var play_quest = $UI/PlayQuest
@onready var play_text = $UI/PlayQuest/PlayButton/Play_Text
@onready var star_0 = $UI/RatingSystem/rating_menu/Star0
@onready var star_1 = $UI/RatingSystem/rating_menu/Star1
@onready var star_2 = $UI/RatingSystem/rating_menu/Star2
@onready var star_3 = $UI/RatingSystem/rating_menu/Star3

#Sound
@onready var open_handphone_sound = $Sound/open_handphone_sound
@onready var bgm_lvl_1 = $Sound/day_1_bgm
@onready var finish_quest_sound = $Sound/Finish_quest_sound

var parameters: Dictionary

var status_paket: bool = false

var time_left: int

func _ready():
	pause_text.visible = false
	play_text.visible = false
	timer.start()
	handphone.play("Quest_Appear");
	open_handphone_sound.play()
	await open_handphone_sound.finished
	get_tree().paused = true
	
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
	if time_left >= GOOD_TIME:  # More than 2 minutes
		_show_rating(3)
	elif time_left >= NORMAL_TIME and time_left < GOOD_TIME:  # More than 1 minute
		_show_rating(2)
	elif time_left > BAD_TIME and time_left < NORMAL_TIME:  # More than 0 seconds
		_show_rating(1)
	elif time_left <= BAD_TIME:  # 0 seconds or less
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
