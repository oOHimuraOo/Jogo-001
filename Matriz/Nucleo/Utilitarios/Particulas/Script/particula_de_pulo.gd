class_name PARTICULA_DE_PULO
extends CPUParticles2D

func _ready():
	one_shot = true
	
func _on_finished():
	queue_free()
