extends Node2D

@onready var quest_timer = $QuestTimer

func _on_quest_timer_timeout():
	TimerManager.debug_print()
	
	pass # Replace with function body.


func _on_play_button_pressed():
	quest_timer.start()
	pass # Replace with function body.
