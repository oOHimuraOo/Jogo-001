class_name CAMERA_CONTROLE
extends Camera2D

var Camera_Alvo:Node2D

var fator_de_aceleracao_da_camera:float = 0.01 #esse valor tem que ser sempre entre 0 e 1
var solicitar_modificacao_de_zoom:bool = false
var novo_fator_de_zoom:float = 3.0 #para afastar o zoom esse valor tem que ser entre 0 e 1. qualquer valor acima de 1 aproxima o zoom.

var olhando_pra_cima:bool = false
var olhando_pra_baixo:bool = false
var fator_de_movimento_vertical_de_camera:float = 10

var Jogador:PERSONAGEM_BASE

func _ready() -> void:
	make_current()

func aplicar_alvo_da_camera(Alvo:Node2D) -> void:
	Camera_Alvo = Alvo
	Jogador = null
	if Camera_Alvo is PERSONAGEM_BASE:
		Jogador = Camera_Alvo as PERSONAGEM_BASE

func aplique_limitacoes(esquerda:float = 0, direita:float = 3840, cima:float = -3840, baixo:float = 540) -> void:
	limit_left = esquerda
	limit_right = direita
	limit_top = cima
	limit_bottom = baixo

func _physics_process(delta):
	if !Jogador:
		siga_alvo(delta)
	else:
		siga_jogador_alvo(delta)
	if solicitar_modificacao_de_zoom == true:
		aplique_zoom(delta, novo_fator_de_zoom)

func aplique_zoom(delta:float, fator:float = 3) -> void:
	zoom = lerp(zoom, Vector2(fator, fator), 1 - pow(fator_de_aceleracao_da_camera, delta))
	if fator > zoom.x:
		if fator - zoom.x <= 0.00001:
			solicitar_modificacao_de_zoom = false
	elif fator == zoom.x:
		solicitar_modificacao_de_zoom = false
	elif fator < zoom.x:
		if zoom.x - fator <= 0.00001:
			solicitar_modificacao_de_zoom = false

func siga_alvo(delta) -> void:
	global_position = lerp(global_position, Camera_Alvo.global_position, 1 - pow(fator_de_aceleracao_da_camera, delta))

func siga_jogador_alvo(delta) -> void:
	solicitar_modificacao_de_zoom = true
	#aprofundar posteriormente funcionalidade da camera aplicando movimentação especial pra camera de acordo com instancias de combate.
	global_position = lerp(global_position, Camera_Alvo.global_position, 1 - pow(fator_de_aceleracao_da_camera, delta))
	
	if olhando_pra_cima == true:
		global_position.y -= fator_de_movimento_vertical_de_camera
	elif olhando_pra_baixo == true:
		global_position.y += fator_de_movimento_vertical_de_camera


