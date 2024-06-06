extends Area2D

@onready var player = get_tree().get_first_node_in_group("player")
@onready var lumpur = $Lumpur


func _on_body_entered(body):
	lumpur.play()
	player.MAX_SPEED = 100

func _on_body_exited(body):
	lumpur.stop()
	player.MAX_SPEED = 200
