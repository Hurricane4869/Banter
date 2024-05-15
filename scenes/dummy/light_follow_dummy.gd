extends CharacterBody2D

const SPEED = 200 # Set a higher speed to follow the mouse faster

func _physics_process(delta):
	var direction = get_viewport().get_mouse_position() - self.position
	velocity = direction * delta * SPEED
	move_and_slide()
