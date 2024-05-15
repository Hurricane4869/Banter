extends Node2D

@onready var interaction_area: InteractionArea = $Environment/AntarPaket
@onready var play_button = $UI/PlayDummy
@onready var timer = $UI/QuestTimer
@onready var timer_node = get_node("UI/QuestTimer/Timer")
@onready var pause_button = $UI/Pause
@onready var pause_text = get_node("UI/Pause/Pause_Text")
@onready var pause_menu = $UI/PauseMenu
@onready var handphone = $CanvasLayer/PlayQuest/Handphone
@onready var play_quest = $CanvasLayer/PlayQuest
@onready var play_text = $CanvasLayer/PlayQuest/PlayButton/Play_Text
@onready var open_handphone = $open_handphone
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

var parameters: Dictionary # Properti parameters dideklarasikan di sini
var status_paket: bool = false

func _ready():
	pause_text.visible = false
	play_text.visible = false
	get_tree().paused = true
	handphone.play("Quest_Appear");
	open_handphone.play()
	await open_handphone.finished
	rating_dummy.visible = false
	#transition.play("fade_in")
	
func _process(_delta):
	interaction_area.interact = Callable(self, "_antar_paket")
	pass
	
func _antar_paket():
	print_debug("Paket Sampai")
	status_paket = true
	timer_node.set_paused(true)

func _hide(second):
	second.hide()

func _on_pause_pressed():
	$UI/PauseMenu.pause()

func _on_pause_mouse_entered():
	pause_text.visible = true

func _on_pause_mouse_exited():
	pause_text.visible = false

func _on_play_button_pressed():
	handphone.play_backwards("Start_Quest")
	get_tree().paused = false
	open_handphone.play()
	await open_handphone.finished
	timer_node.start()
  time_left = timer_node.get_time_left()
	rating_system._process_rating(time_left)	
	get_tree().paused = true
	black_overlay.visible = true
	rating_dummy.visible = true
	play_button.hide()
	#print("waktu tersisa: " + str(time_left))


func _on_play_button_mouse_entered():
	play_text.visible = true	

func _on_play_button_mouse_exited():
	play_text.visible = false

func _on_texture_button_pressed():
	pass # Replace with function body.
	
func _on_play_dummy_pressed():
	timer_node.start()

