extends CharacterBody2D
# Kecepatan gerakan dalam pixels per second
@export var speed = 0

@export var _sprites = {Vector2.RIGHT: 1, Vector2.LEFT: 0, Vector2.UP: 2, Vector2.DOWN: 3}

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var light_h = $Lighting/LightBeam_Horizontal
@onready var light_up = $Lighting/LightBeam_Up
@onready var light_down = $Lighting/LightBeam_Down
@onready var collision = $CollisionShape2D

func _ready():
	light_h.show()
	light_up.hide()
	light_down.hide()
	
func _physics_process(_delta) :
	# Memanggil fungsi "Input.get_action_strength()" untuk dukungan controller
	var direction = Vector2(
		# Menghitung arah sumbu X
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		# Menghitung arah sumbu Y
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	#var direction = Input.get_vector("left", "right", "up", "down")
	
	if direction.length() > 1.0:
		direction = direction.normalized()
	velocity = speed * direction
	move_and_slide()
	
	if velocity.x > 0:
		_update_collision(Vector2.RIGHT)
		_update_sprite(Vector2.RIGHT)
		light_down.hide()
		light_up.hide()
		light_h.show()
		light_h.scale.x = abs(light_h.scale.x) * -1
	elif velocity.x < 0:
		_update_collision(Vector2.LEFT)
		_update_sprite(Vector2.LEFT)
		light_down.hide()
		light_up.hide()
		light_h.show()
		light_h.scale.x = abs(light_h.scale.x)
	elif velocity.y < 0:
		_update_collision(Vector2.UP)
		_update_sprite(Vector2.UP)
		light_h.hide()
		light_down.hide()
		light_up.show()
	elif velocity.y > 0:
		_update_collision(Vector2.DOWN)
		_update_sprite(Vector2.DOWN)
		light_up.hide()
		light_h.hide()
		light_down.show()
	
func _update_sprite(direction: Vector2) -> void:
	animated_sprite.frame = _sprites[direction]

func _update_collision(direction: Vector2):
	match direction:
		Vector2.RIGHT:
			collision.rotation_degrees = 0
			collision.position = Vector2(6.5, 28.5)
		Vector2.LEFT:
			collision.rotation_degrees = 0
			collision.position = Vector2(-6.5, 28.5)
		Vector2.UP:
			collision.rotation_degrees = 90
			collision.position = Vector2(-3, 12)
		Vector2.DOWN:
			collision.rotation_degrees = 90
			collision.position = Vector2(0, 20)
			

