extends CharacterBody2D

@export var ACCEL: int = 0
@export var FRICTION: int = 0
@export var MAX_SPEED: int = 0
@export var starting_direction: Vector2

enum {IDLE, DRIVE}
var state = IDLE

@onready var direction: Vector2
@onready var animationTree = $AnimationTree
@onready var state_machine = animationTree["parameters/playback"]

# var untuk menyimpan arah gerakan terakhir untuk animasi idle
var blend_position: Vector2 = Vector2.ZERO
var blend_pos_paths = [
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
@onready var collision_base = $CollisionShape2D
@onready var collision_area2d = $Area2D/CollisionShape2D
@onready var camera = $Camera2D
@onready var idle_motor = $IdleMotor
@onready var driving_motor = $DrivingMotor

func _ready():
	set_camera_limit()
	state = IDLE
	blend_position = starting_direction
	animate()
	update_light_collision(blend_position)

func _physics_process(delta):
	move(delta)
	animate()
	if blend_position.x > 0:
		update_light_collision(Vector2.RIGHT) 
	elif blend_position.x < 0:
		update_light_collision(Vector2.LEFT) 
	elif blend_position.y > 0: 
		update_light_collision(Vector2.DOWN) 
	elif  blend_position.y < 0:
		update_light_collision(Vector2.UP)
	update_audio(true)

func update_audio(is_playing: bool) -> void:
	if state == IDLE:
		if is_playing and !idle_motor.is_playing():
			idle_motor.play()
		elif !is_playing:
			idle_motor.stop()
	elif state == DRIVE:
		if is_playing and !driving_motor.is_playing():
			driving_motor.play()
		elif !is_playing:
			driving_motor.stop()


func set_camera_limit():
	var tilemap_rect = get_parent().get_node("Environment/WorldLimit").get_used_rect()
	var tilemap_cell_size = get_parent().get_node("Environment/WorldLimit").tile_set.tile_size
	camera.limit_left = tilemap_rect.position.x * tilemap_cell_size.x
	camera.limit_right = tilemap_rect.end.x * tilemap_cell_size.x
	camera.limit_top = tilemap_rect.position.y * tilemap_cell_size.y
	camera.limit_bottom = tilemap_rect.end.y * tilemap_cell_size.y
	
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
	animationTree.set(blend_pos_paths[state], blend_position)

func update_light_collision(position: Vector2) -> void:
	match position:
		Vector2.RIGHT:
			collision_base.rotation_degrees = 0
			collision_base.position = Vector2(6.5, 28.5)
			collision_area2d.rotation_degrees = 0
			collision_area2d.position = Vector2(6.5, 28.5)
			light_down.hide()
			light_up.hide()
			light_h.show()
			light_h.scale.x = abs(light_h.scale.x) * -1
		Vector2.LEFT:
			collision_base.rotation_degrees = 0
			collision_base.position = Vector2(-6.5, 28.5)
			collision_area2d.rotation_degrees = 0
			collision_area2d.position = Vector2(-6.5, 28.5)
			light_down.hide()
			light_up.hide()
			light_h.show()
			light_h.scale.x = abs(light_h.scale.x) * 1
		Vector2.UP:
			collision_base.rotation_degrees = 90
			collision_base.position = Vector2(-3, 12)
			collision_area2d.rotation_degrees = 90
			collision_area2d.position = Vector2(-3, 12)
			light_h.hide()
			light_down.hide()
			light_up.show()
		Vector2.DOWN:
			collision_base.rotation_degrees = 90
			collision_base.position = Vector2(0, 20)
			collision_area2d.rotation_degrees = 90
			collision_area2d.position = Vector2(0, 20)
			light_up.hide()
			light_h.hide()
			light_down.show()

func _on_area_2d_area_entered(area):
	if area.is_in_group("lumpur"):
		MAX_SPEED = 100

func _on_area_2d_area_exited(area):
		MAX_SPEED = 200
