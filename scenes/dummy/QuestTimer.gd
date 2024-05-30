extends Timer

@export var second: int
@export var minute: int

#@onready var timer = $Timer
@onready var label = $Label
@onready var timer_status: bool = true

func _ready():
	var time = (minute*60) + second
	set_wait_time(time)

func _time_left(): 
	var minute = floor(time_left / 60)
	var second = int(time_left) % 60
	return [minute, second]
	
func _process(delta):
	label.text = "%02d:%02d" % _time_left()

