extends Node2D

@onready var quest_timer = get_node("CanvasLayer/QuestTimer/Timer")


func _on_play_button_pressed():
	quest_timer.start()
	pass
