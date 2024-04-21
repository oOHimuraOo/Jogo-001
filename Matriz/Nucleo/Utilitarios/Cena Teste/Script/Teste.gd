extends Node2D

func _ready():
	instanciar_camera_e_personagem()

func instanciar_camera_e_personagem():
	var personagem_cena = load("res://Matriz/Nucleo/Personagem/Cena/Personagem.tscn")
	var personagem_instancia = personagem_cena.instantiate()
	personagem_instancia.position += Vector2(100, 30)
	add_child(personagem_instancia)

	var camera_cena = load("res://Matriz/Nucleo/Sistema Motor/Controladores/Cena/Camera.tscn")
	var camera_instancia = camera_cena.instantiate()
	camera_instancia.aplicar_alvo_da_camera(personagem_instancia)
	add_child(camera_instancia)
	
	#var inimigo_cena = load("res://Matriz/Nucleo/NPCs/Inimigos/Cena/inimigo_base.tscn")
	#var inimigo_instancia = inimigo_cena.instantiate()
	#inimigo_instancia.personagem = personagem_instancia
	#add_child(inimigo_instancia)


func _process(_delta):
	pass
