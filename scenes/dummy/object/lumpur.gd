extends Area2D

@onready var lumpur = $Lumpur

func _on_body_entered(body):
	lumpur.play()

func _on_body_exited(body):
	lumpur.stop()
