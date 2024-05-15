extends Node2D

@onready var interaction_area: InteractionArea = $AntarPaket
@onready var button = $TextureButton
@onready var timer = $AliTopDown/QuestTimer
@onready var timer_node = get_node("CanvasLayer/QuestTimer/Timer")
@onready var pause = $CanvasLayer/Pause
@onready var pause_menu = $CanvasLayer/PauseMenu
@onready var pause_text = $CanvasLayer/Pause/Pause_Text
@onready var handphone = $CanvasLayer/PlayQuest/Handphone
@onready var play_quest = $CanvasLayer/PlayQuest
@onready var play_text = $CanvasLayer/PlayQuest/PlayButton/Play_Text
@onready var open_handphone = $open_handphone

var parameters: Dictionary # Properti parameters dideklarasikan di sini
var status_paket: bool = false

func _ready():
	pause_text.visible = false
	play_text.visible = false
	get_tree().paused = true
	handphone.play("Quest_Appear");
	open_handphone.play()
	await open_handphone.finished
	
func _process(_delta):
	interaction_area.interact = Callable(self, "_antar_paket")
	
func _antar_paket():
	print_debug("Paket Sampai")
	status_paket = true
	timer_node.set_paused(true)
	
func _hide(second):
	second.hide()

func _on_pause_pressed():
	$CanvasLayer/PauseMenu.pause()

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

func _on_play_button_mouse_entered():
	play_text.visible = true	

func _on_play_button_mouse_exited():
	play_text.visible = false

func _on_texture_button_pressed():
	pass # Replace with function body.
