extends CharacterBody2D

@export var ACCEL:  = 0
@export var FRICTION = 0
@export var MAX_SPEED = 0

enum {IDLE, DRIVE}
var state = IDLE

@onready var direction: Vector2
@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

# var untuk menyimpan arah gerakan terakhir untuk animasi idle
var blend_position: Vector2 = Vector2.ZERO
var blend_pos_path = [
	"parameters/idle/idle_bs2d/blend_position", 
	"parameters/drive/drive_bs2d/blend_position"
]
var animTree_state_keys = [
	"idle", 
	"drive"
]

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var light_h = $Lighting/LightBeam_Horizontal
@onready var light_up = $Lighting/LightBeam_Up
@onready var light_down = $Lighting/LightBeam_Down
@onready var collision = $CollisionShape2D


func _ready():
	light_h.show()
	light_up.hide()
	light_down.hide()

func _physics_process(delta):
	move(delta)
	animate()
	update_light_collision()

func move(delta):
	direction = Vector2(
		Input.get_vector("left", "right", "up", "down")
	)
	# Mengecek kondisi input untuk menentukan 
	if direction == Vector2.ZERO:
		state = IDLE
		apply_friction(FRICTION * delta)
	else: 
		state = DRIVE
		apply_movement(direction * ACCEL * delta)
		blend_position = direction
	move_and_slide()

func apply_friction(amount) -> void:
	if velocity.length() > amount:
		velocity = velocity.normalized() * amount
	else: 
		velocity = Vector2.ZERO

func apply_movement(amount) -> void:
	velocity += amount 
	# Membatasi kecepatan maksimal
	velocity = velocity.limit_length(MAX_SPEED)

func animate() -> void:
	state_machine.travel(animTree_state_keys[state])
	animationTree.set(blend_pos_path[state], blend_position)

func update_light_collision() -> void:
	match direction:
		Vector2.RIGHT:
			collision.rotation_degrees = 0
			collision.position = Vector2(6.5, 28.5)
			light_down.hide()
			light_up.hide()
			light_h.show()
			light_h.scale.x = abs(light_h.scale.x) * -1
		Vector2.LEFT:
			collision.rotation_degrees = 0
			collision.position = Vector2(-6.5, 28.5)
			light_down.hide()
			light_up.hide()
			light_h.show()
			light_h.scale.x = abs(light_h.scale.x) * 1
		Vector2.UP:
			collision.rotation_degrees = 90
			collision.position = Vector2(-3, 12)
			light_h.hide()
			light_down.hide()
			light_up.show()
		Vector2.DOWN:
			collision.rotation_degrees = 90
			collision.position = Vector2(0, 20)
			light_up.hide()
			light_h.hide()
			light_down.show()

