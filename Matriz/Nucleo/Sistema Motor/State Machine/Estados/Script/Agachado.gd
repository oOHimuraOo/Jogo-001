class_name ESTADO_AGACHADO
extends ESTADO_BASE

var novo_offset:float = 5.375
var velho_offset:float = 0

var novo_tamanho:Vector2 = Vector2(25,20.75)
var velho_tamanho:Vector2 = Vector2(25,31.5)

var velocidade_horizontal_alvo:float
var parou:bool = false

func ao_entrar_no_estado(_info:Dictionary = {}) -> void:
	super(_info)
	Dono_do_estado.area_de_colisao.position.y = novo_offset
	Dono_do_estado.area_de_colisao.shape.size = novo_tamanho

func ao_sair_do_estado(_info:Dictionary = {}) -> void:
	Dono_do_estado.area_de_colisao.position.y = velho_offset
	Dono_do_estado.area_de_colisao.shape.size = velho_tamanho
	Dono_do_estado.detector_de_chao_direita.hide()
	Dono_do_estado.detector_de_chao_esquerda.hide()
	Dono_do_estado.detector_de_chao_direita.enabled = false
	Dono_do_estado.detector_de_chao_esquerda.enabled = false

func no_physics_process(_delta:float) -> void:
	lidar_com_animacao(_delta)
	lidar_com_detector_de_chao()
	limitador_de_movimento()
	lidar_com_som_do_personagem()

func lidar_com_som_do_personagem() -> void:
	match Animacao.frame:
		0:
			if parou == false:
				DATA.SON.tocar_efeitos_sonoros_ecolocalisaveis(Dono_do_estado, Dono_do_estado.global_position, lista_de_efeitos_sonoros.pick_random())

func limitador_de_movimento() -> void:
	if direcao_de_movimento != 0:
		if Dono_do_estado.detector_de_chao_direita.is_colliding() && Dono_do_estado.is_on_floor():
			parou = false
			Dono_do_estado.velocity.x = velocidade_horizontal_alvo 
			Dono_do_estado.move_and_slide()
		elif Dono_do_estado.detector_de_chao_esquerda.is_colliding() && Dono_do_estado.is_on_floor():
			parou = false
			Dono_do_estado.velocity.x = velocidade_horizontal_alvo 
			Dono_do_estado.move_and_slide()
		else:
			parou = true
	else:
		parou = true

func lidar_com_detector_de_chao() -> void:
	if Dono_do_estado.detector_de_chao_direita.is_visible_in_tree():
		if direcao_de_movimento > 0:
			Dono_do_estado.detector_de_chao_esquerda.hide()
			Dono_do_estado.detector_de_chao_esquerda.enabled = false
		elif direcao_de_movimento < 0:
			Dono_do_estado.detector_de_chao_direita.hide()
			Dono_do_estado.detector_de_chao_direita.enabled = false
		else:
			Dono_do_estado.detector_de_chao_direita.hide()
			Dono_do_estado.detector_de_chao_esquerda.hide()
			Dono_do_estado.detector_de_chao_direita.enabled = false
			Dono_do_estado.detector_de_chao_esquerda.enabled = false
	else:
		if direcao_de_movimento > 0:
			Dono_do_estado.detector_de_chao_direita.show()
			Dono_do_estado.detector_de_chao_direita.enabled = true
		elif direcao_de_movimento < 0:
			Dono_do_estado.detector_de_chao_esquerda.show()
			Dono_do_estado.detector_de_chao_esquerda.enabled = true
		else:
			Dono_do_estado.detector_de_chao_direita.hide()
			Dono_do_estado.detector_de_chao_esquerda.hide()
			Dono_do_estado.detector_de_chao_direita.enabled = false
			Dono_do_estado.detector_de_chao_esquerda.enabled = false

func lidar_com_animacao(_delta) -> void:
	if direcao_de_movimento != 0 && parou == false:
		Animacao.play(self.name + "_andando")
		lidar_com_movimentacao_horizontal(_delta)
	elif direcao_de_movimento != 0 && parou == true:
		Animacao.play(self.name + "_parado")
	else:
		Animacao.play(self.name + "_parado")

func lidar_com_movimentacao_horizontal(_delta:float) -> void:
	if sign(direcao_de_movimento) != sign(Dono_do_estado.velocity.x) && Dono_do_estado.velocity.x != 0:
		velocidade_horizontal_alvo = 0
	else:
		velocidade_horizontal_alvo = lerp(Dono_do_estado.velocity.x, direcao_de_movimento * Dono_do_estado.valores_do_jogador.velocidade_de_movimento, 1 - pow(Dono_do_estado.valores_do_jogador.fator_de_aceleracao, _delta))

func verificar_transicao_de_estado() -> void:
	super()
	if !Input.is_action_pressed("S") && direcao_de_movimento != 0:
		MDE.mudar_estado_ativo("Movimento", "Andando")
		return

	if !Input.is_action_pressed("S") && direcao_de_movimento == 0:
		MDE.mudar_estado_ativo("Movimento", "Parado")
		return
