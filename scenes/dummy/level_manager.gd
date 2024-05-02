extends Node2D

@onready var interaction_area: InteractionArea = $AntarPaket
@onready var button = $TextureButton
@onready var timer = $AliTopDown/QuestTimer
@onready var timer_node = get_node("AliTopDown/QuestTimer/Timer")

var status_paket: bool = false

#func _ready():
	#transition.play("fade_in")
	
func _process(delta):
	interaction_area.interact = Callable(self, "_antar_paket")
	
func _antar_paket():
	print_debug("Paket Sampai")
	status_paket = true
	timer_node.set_paused(true)
	
	
func _hide(second):
	second.hide()

func _on_texture_button_pressed():
	timer_node.start()
	_hide(button)
	
	
