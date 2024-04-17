extends Node2D

@onready var timer = $QuestTimer

func _on_play_button_pressed():
	var timer_node = get_node("QuestTimer/Timer")
	timer_node.start()
	pass
