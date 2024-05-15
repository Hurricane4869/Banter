extends Node2D

@export var second: int
@export var minute: int

@onready var timer = $Timer
@onready var label = $Label
@onready var timer_status: bool = true

func _ready():
	var time = (minute*60) + second
	timer.set_wait_time(time)

func _time_left():
	var time_left = timer.time_left 
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _process(_delta):
	label.text = "%02d:%02d" % _time_left()


func _on_timer_timeout():
	get_tree().paused = true
