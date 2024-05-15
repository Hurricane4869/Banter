extends Node2D

@onready var interaction_area: InteractionArea = $Environment/AntarPaket
@onready var play_button = $UI/PlayDummy
@onready var timer = $UI/QuestTimer
@onready var timer_node = get_node("UI/QuestTimer/Timer")
@onready var pause_button = $UI/Pause
@onready var pause_text = get_node("UI/Pause/Pause_Text")
@onready var pause_menu = $UI/PauseMenu
@onready var black_overlay = get_node("UI/PauseMenu/ColorRect")
@onready var rating_dummy = get_node("UI/RatingSystem/RatingDummy")
@onready var rating_system = $UI/RatingSystem

#rating
@onready var perfect_time = 60
@onready var half_time = 30
@onready var bad_time = 5

@onready var perfect_rating = 3
@onready var half_rating = 2
@onready var bad_rating = 1

var time_left

var parameters: Dictionary

var status_paket: bool = false

func _ready():
	rating_dummy.visible = false
	#transition.play("fade_in")
	
func _process(delta):
	interaction_area.interact = Callable(self, "_antar_paket")
	pass
	
func _antar_paket():
	print_debug("Paket Sampai")
	status_paket = true
	timer_node.set_paused(true)
	
	time_left = timer_node.get_time_left()
	rating_system._process_rating(time_left)
	
	get_tree().paused = true
	black_overlay.visible = true
	rating_dummy.visible = true
	
	#print("waktu tersisa: " + str(time_left))

func _on_play_dummy_pressed():
	timer_node.start()
	play_button.hide()
	
func _on_pause_pressed():
	pause_menu.pause()

func _on_pause_mouse_entered():
	pause_text.visible = true

func _on_pause_mouse_exited():
	pause_text.visible = false
