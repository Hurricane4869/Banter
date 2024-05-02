extends Node2D

var parameters: Dictionary

@onready var interaction_area: InteractionArea = $ColorTile
@onready var texture = $ColorTile/TextureRect
@onready var transition = $Transition

var white = Color(255, 255, 2555)
var blue = Color(1, 0, 255)
var orange = Color(255, 215, 1)
var color = ["blue", "orange"]

@onready var pause = $CanvasLayer/Pause
@onready var pause_text = $CanvasLayer/Pause/Pause_Text
@onready var pause_menu = $CanvasLayer/PauseMenu


func _ready():
	randomize()
	texture.modulate = white
	pause_text.visible = false

func _process(delta):
	interaction_area.interact = Callable(self, "_change_color")
	
func _change_color(): 
	var random_color = color[randi() % color.size()]
	if random_color == "blue":
		texture.modulate = blue
	if random_color == "orange":
		texture.modulate = orange

func _on_pause_pressed():
	$CanvasLayer/PauseMenu.pause()

func _on_pause_mouse_entered():
	pause_text.visible = true

func _on_pause_mouse_exited():
	pause_text.visible = false

func _on_pause_hidden():
	pass # Replace with function body.
