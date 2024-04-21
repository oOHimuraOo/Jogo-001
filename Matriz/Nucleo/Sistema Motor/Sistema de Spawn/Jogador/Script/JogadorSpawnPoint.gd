@icon("res://Assets/Place Holder/Icones/PC Computer - Roblox - Spawn Location.png")
class_name JOGADOR_SPAWN_POINT
extends Control

@onready var ponto_de_spawn = $ponto_de_spawn
var personagem:PERSONAGEM_BASE
var idx:int

func _ready():
	idx = find_parent("Nova_Cena_Teste").index_do_personagem
	modificar_ponto_de_spawn()
	instanciar_jogador()
	instanciar_camera()

func modificar_ponto_de_spawn(Novo_ponto:Vector2 = Vector2(960,1030)) -> void:
	ponto_de_spawn.position = Novo_ponto

func instanciar_jogador() -> void:
	var jogador_instancia:PERSONAGEM_BASE = DATA.CON.Personagem_Base.instantiate()
	jogador_instancia.position = ponto_de_spawn.position
	jogador_instancia.idx = idx
	find_parent("Nova_Cena_Teste").find_child("Personagem").add_child(jogador_instancia)
	personagem = jogador_instancia

func instanciar_camera() -> void:
	var camera_instancia:CAMERA_CONTROLE = DATA.CON.Camera_Controle.instantiate()
	camera_instancia.aplicar_alvo_da_camera(personagem)
	find_parent("Nova_Cena_Teste").find_child("Camera").add_child(camera_instancia)
