extends CharacterBody2D

@onready var ghost_animation = $ghost_animation
@onready var black_screen = $Black_Screen
@export var waktu_pingsan : int
@onready var ghost_hit_sound = $Ghost_hit_sound
@onready var ghost_chase_sound = $Ghost_chase_sound

var speed = 80
var player_chase = false
var player = null
var direction = Vector2()

func _physics_process(delta):
	if player_chase:
		direction = (player.position - position).normalized()
		position += direction * speed * delta
		# Memilih animasi berdasarkan arah pergerakan
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				ghost_animation.play("right")
			else:
				ghost_animation.play("left")
		else:
			if direction.y > 0:
				ghost_animation.play("down")
			else:
				ghost_animation.play("up")

func _on_detection_area_body_entered(body):
	ghost_chase_sound.play()
	player = body
	player_chase = true

func _on_detection_area_body_exited(body):
	ghost_chase_sound.stop()
	player = null
	player_chase = false

func _on_stun_area_body_entered(body):
	if body.is_in_group("player"):
		ghost_chase_sound.stop()
		ghost_hit_sound.play()
		black_screen.visible = true
		player_chase = false  # Hentikan pengejaran hantu
		body.set_physics_process(false)  # Hentikan pergerakan player
		await get_tree().create_timer(waktu_pingsan).timeout  # Tunggu selama 5 detik
		body.set_physics_process(true)  # Kembalikan pergerakan player
		black_screen.visible = false
		queue_free()  # Hapus hantu dari scene
