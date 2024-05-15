extends CanvasLayer

@export_file("*.tscn") var next_scene_path: String
@onready var animation_player = $AnimationPlayer
var parameters: Dictionary # Properti parameters dideklarasikan di sini

# Called when the node enters the scene tree for the first time.
func _ready():
	ResourceLoader.load_threaded_request(next_scene_path)
	animation_player.play_backwards("Init")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if ResourceLoader.load_threaded_get_status(next_scene_path) == ResourceLoader.THREAD_LOAD_LOADED:
		set_process(false)
		await get_tree().create_timer(1).timeout
		var new_scene: PackedScene = ResourceLoader.load_threaded_get(next_scene_path)
		var new_node = new_scene.instantiate()
		new_node.parameters = parameters # Properti parameters digunakan di sini
		var current_scene = get_tree().current_scene
		get_tree().get_root().add_child(new_node)
		get_tree().current_scene = new_node
		current_scene.queue_free()
