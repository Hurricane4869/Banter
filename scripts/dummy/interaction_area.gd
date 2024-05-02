extends Area2D
class_name InteractionArea

@export var action_name: String = "interact" #teks yang akan muncul di atas objek yang bisa diinteraksi

var interact: Callable = func(): #variabel uang memuat fungsi, seperti struct
	pass

func _on_body_entered(body):
	InteractionManager.register_area(self)

func _on_body_exited(body):
	InteractionManager.unregister_area(self)
