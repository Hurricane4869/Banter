extends CharacterBody2D

# Kecepatan gerakan dalam pixels per second
@export var speed := 500

# Memetakan arah dengan indeks frame animasi yang ada pada AnimatedSprite node.
var _sprites := {Vector2.RIGHT: 1, Vector2.LEFT: 0, Vector2.UP: 2, Vector2.DOWN: 3}
var _velocity := Vector2.ZERO

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Memanggil fungsi "Input.get_action_strength()" untuk dukungan controller
	var direction := Vector2(
		# Menghitung arah sumbu X
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		# Menghitung arah sumbu Y
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	if direction.length() > 1.0:
		direction = direction.normalized()
	velocity = speed * direction
	move_and_slide()
	
# Mengupdate arah sprite sesuai dengan input 
func _unhandled_input(event):
	if event.is_action_pressed("right"):
		_update_sprite(Vector2.RIGHT)
	elif event.is_action_pressed("left"):
		_update_sprite(Vector2.LEFT)
	elif event.is_action_pressed("up"):
		_update_sprite(Vector2.UP)
	elif event.is_action_pressed("down"):
		_update_sprite(Vector2.DOWN)

func _update_sprite(direction: Vector2) -> void:
	animated_sprite.frame = _sprites[direction]
