extends Node2D

@onready var interaction_area: InteractionArea = $ColorTile
@onready var texture = $ColorTile/TextureRect

var white = Color(255, 255, 2555)
var blue = Color(1, 0, 255)
var orange = Color(255, 215, 1)
var color = ["blue", "orange"]

func _ready():
	randomize()
	texture.modulate = white
	interaction_area.interact = Callable(self, "_change_color")
	
func _change_color(): 
	var random_color = color[randi() % color.size()]
	if random_color == "blue":
		texture.modulate = blue
	if random_color == "orange":
		texture.modulate = orange
