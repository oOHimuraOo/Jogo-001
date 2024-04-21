@icon("res://Assets/Place Holder/Icones/Ak47.png")
class_name ARMA_BASICA_DE_LONGA_DISTANCIA 
extends Node2D

var personagem:PERSONAGEM_BASE

var rotacao_em_uso:float
var rotacao_de_descanso:float = -75
@onready var textura:Sprite2D = $Textura

var alcance_da_bala:float = 200
var variacao_de_mira_enquanto_parado:float = 0/PI
var variacao_de_mira_enquanto_em_movimento:float = 1/PI
var variacao_de_mira_atual:float = 0
var variacao_de_mira_alvo:float = 0
var valor_de_ajuste_de_variacao_de_mira:float = 0.02
var variacao_de_tiro:float = 0.02/PI
var posicao_local_alvo:Vector2
@onready var assistencia_de_mira:Line2D = $AssistenciaDeMira
@onready var assistencia_de_mira_2:Line2D = $AssistenciaDeMira2
@onready var ponto_de_saida:Marker2D = $PontoDeSaida

var balas_por_segundo:float = 10
var tempo_de_espera_do_temporizador:float = 0
@onready var temporizador_de_balas_por_segundo:Timer = $TemporizadorDeBalasPorSegundo

@onready var verificador_de_tiro_acertado:RayCast2D = $VerificadorDeTiroAcertado

var mascara_de_colisao:int = 0b00000000_00000000_00000000_10000011
var ativa:bool = true
var tipo:String = "Perfurante"
var dano:float = 10

var index:int
var nome:String
var nivel:int
var descricao:String

func _ready():
	inicializar_valores()
	verificador_de_tiro_acertado.collision_mask = mascara_de_colisao

func _process(delta:float) -> void:
	if personagem.morto == false:
		if ativa == true:
			arma_ativa_controlador(delta)
		else:
			arma_passiva_controlador(delta)

func arma_ativa_controlador(delta:float) -> void:
	if personagem.maquina_de_estados.get_child(1).name == personagem.maquina_de_estados.estado_ativo.get_parent().name:
		self.show()
		atualizar_rotacao_da_arma()
		corrigir_offset(ponto_de_saida)
		if Input.is_action_pressed("Atirar"):
			lidar_com_tiros(delta)
		
		assistencia_de_mira.visible = Input.is_action_pressed("Mirar")
		assistencia_de_mira_2.visible = Input.is_action_pressed("Mirar")
		if Input.is_action_pressed("Mirar"):
			atualizar_assistencia_de_mira(delta)
	else:
		self.hide()
		assistencia_de_mira.visible = false
		assistencia_de_mira_2.visible = false
		rotation = rotacao_de_descanso
		textura.flip_v = false

func arma_passiva_controlador(delta:float) -> void:
	if get_parent().get_child(0) == self:
		self.show()
	else:
		self.hide()
	atualizar_rotacao_da_arma()
	corrigir_offset(ponto_de_saida)
	if atirar_automaticamente() == true:
		lidar_com_tiros(delta)
	
	if personagem.maquina_de_estados.get_child(1).name == personagem.maquina_de_estados.estado_ativo.get_parent().name:
		atualizar_assistencia_de_mira(delta)
		assistencia_de_mira.visible = true
		assistencia_de_mira_2.visible = true
	else:
		atualizar_assistencia_de_mira(delta)
		assistencia_de_mira.visible = false
		assistencia_de_mira_2.visible = false

func atirar_automaticamente() -> bool:
	return true

func inicializar_valores() -> void:
	if ativa == true:
		tempo_de_espera_do_temporizador = 1/balas_por_segundo
		temporizador_de_balas_por_segundo.wait_time = tempo_de_espera_do_temporizador
	else:
		balas_por_segundo = balas_por_segundo / 4
		tempo_de_espera_do_temporizador = 1/balas_por_segundo
		temporizador_de_balas_por_segundo.wait_time = tempo_de_espera_do_temporizador

func lidar_com_tiros(delta:float) -> void:
	if !temporizador_de_balas_por_segundo.is_stopped():
		return
	
	var info = verificar_se_tiro_acertado(delta)
	if info["Acerto"] == true:
		if info["Tipo"] == "Cenario":
			if info["Destrutivel"] == true:
				pass
			else:
				pass
		elif info["Tipo"] == "Objeto":
			if info["Destrutivel"] == true:
				pass
			else:
				pass
		elif info["Tipo"] == "Inimigo":
			var alvo = info["Colisao"]
			if alvo is INIMIGO_BASE:
				alvo.sistema_de_dano.calculadora_de_dano_de_vida(false,tipo,personagem.valores_do_jogador.forca,dano)
		else:
			if info["Destrutivel"] == true:
				pass
			else:
				pass
		
	temporizador_de_balas_por_segundo.start()

func atualizar_rotacao_da_arma() -> void:
	rotation = (get_global_mouse_position() - global_position).angle()
	if get_global_mouse_position().x < global_position.x:
		textura.flip_v = true
	else:
		textura.flip_v = false

func determinando_variacao_de_mira(delta:float) -> void:
	if personagem.maquina_de_estados.estado_ativo.name == "Combate" && Input.is_action_pressed("Mirar") || personagem.maquina_de_estados.estado_ativo.direcao_de_movimento == 0:
		variacao_de_mira_alvo = variacao_de_mira_enquanto_parado
	if personagem.maquina_de_estados.estado_ativo.name == "Combate" && !Input.is_action_pressed("Mirar"):
		variacao_de_mira_alvo = variacao_de_mira_enquanto_em_movimento / 4
	if personagem.maquina_de_estados.estado_ativo.name == "CombateAndando" || personagem.maquina_de_estados.estado_ativo.direcao_de_movimento != 0:
		variacao_de_mira_alvo = variacao_de_mira_enquanto_em_movimento 

	variacao_de_mira_atual = lerp(variacao_de_mira_atual, variacao_de_mira_alvo, 1 - pow(valor_de_ajuste_de_variacao_de_mira, delta))

func atualizar_assistencia_de_mira(delta:float) -> void:
	posicao_local_alvo = ponto_de_saida.position + (get_local_mouse_position().normalized() * alcance_da_bala)
	
	determinando_variacao_de_mira(delta)
	
	var angulo_alvo:float = posicao_local_alvo.angle()
	var rotacao_minima_alvo:float = (angulo_alvo - variacao_de_mira_atual)
	var direcao_minima_alvo:Vector2 = Vector2(cos(rotacao_minima_alvo), sin(rotacao_minima_alvo))
	var rotacao_maxima_alvo:float = (angulo_alvo + variacao_de_mira_atual)
	var direcao_maxima_alvo:Vector2 = Vector2(cos(rotacao_maxima_alvo), sin(rotacao_maxima_alvo))
	
	assistencia_de_mira.points[0] = ponto_de_saida.position
	assistencia_de_mira.points[1] = direcao_minima_alvo * alcance_da_bala
	assistencia_de_mira_2.points[0] = ponto_de_saida.position
	assistencia_de_mira_2.points[1] = direcao_maxima_alvo * alcance_da_bala

func verificar_se_tiro_acertado(delta:float) -> Dictionary:
	determinando_variacao_de_mira(delta)
	verificador_de_tiro_acertado.global_position = ponto_de_saida.global_position
	
	var angulo_alvo:float = get_local_mouse_position().normalized().angle()
	var rotacao_alvo:float = angulo_alvo + randf_range(-variacao_de_mira_atual, variacao_de_mira_atual)
	var posicao_alvo_final:Vector2 = (Vector2(cos(rotacao_alvo), sin(rotacao_alvo)) * alcance_da_bala)
	
	verificador_de_tiro_acertado.target_position = posicao_alvo_final
	verificador_de_tiro_acertado.force_raycast_update()
	
	var info:Dictionary = {}
	if verificador_de_tiro_acertado.is_colliding():
		var colisao:Node2D = verificador_de_tiro_acertado.get_collider()
		if colisao.is_in_group("Cenario"):
			if colisao.is_in_group("Destrutivel"):
				info = {"Acerto": true, "Tipo": "Cenario", "Colisao": colisao, "Destrutivel": true}
			else:
				info = {"Acerto": true, "Tipo": "Cenario", "Colisao": colisao, "Destrutivel": false}
		elif colisao.is_in_group("Objeto"):
			if colisao.is_in_group("Destrutivel"):
				info = {"Acerto": true, "Tipo": "Objeto", "Colisao": colisao, "Destrutivel": true}
			else:
				info = {"Acerto": true, "Tipo": "Objeto", "Colisao": colisao, "Destrutivel": false}
		elif colisao.is_in_group("Inimigo"):
			info = {"Acerto": true, "Tipo": "Inimigo", "Colisao": colisao.get_parent(), "Destrutivel": false}
		else:
			if colisao.is_in_group("Destrutivel"):
				info = {"Acerto": true, "Tipo": "Outros", "Colisao": colisao, "Destrutivel": true}
			else:
				info = {"Acerto": true, "Tipo": "Outros", "Colisao": colisao, "Destrutivel": false}
		return info
	info = {"Acerto": false}
	return info

func corrigir_offset(nodo:Node2D) -> void:
	if get_global_mouse_position().x < global_position.x:
		nodo.position.y = 5
	else:
		nodo.position.y = -5
	
