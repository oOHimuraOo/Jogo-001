class_name ESTADO_BASE
extends Node

@export var lista_de_efeitos_sonoros:Array[AudioStream] = []

var Dono_do_estado:CharacterBody2D
var Animacao:AnimatedSprite2D
var MDE:MAQUINA_DE_ESTADO

var direcao_de_movimento:float = 0
var morreu:bool = false

func ao_entrar_no_estado(_info:Dictionary = {}) -> void:
	pass

func ao_sair_do_estado(_info:Dictionary = {}) -> void:
	pass

func no_process(_delta:float) -> void:
	verificar_transicao_de_estado()
	lidar_com_direcao_da_animacao()
	lidar_com_input_horizontal()
	verificar_se_esta_vivo()

func verificar_se_esta_vivo() -> void:
	if morreu == false:
		if Dono_do_estado.barra_de_vida.vida_atual <= 0:
			morreu = true

func no_physics_process(_delta:float) -> void:
	pass

func verificar_transicao_de_estado() -> void:
	if morreu == true:
		MDE.mudar_estado_ativo("Especial", "Morrendo")
	
	if Input.is_action_just_pressed("Q") or Input.is_action_just_pressed("Mirar"):
		MDE.mudar_estado_ativo("Combate", "Combate")

func lidar_com_direcao_da_animacao() -> void:
	if direcao_de_movimento == -1:
		Animacao.flip_h = true
	if direcao_de_movimento == 1:
		Animacao.flip_h = false

func lidar_com_input_horizontal() -> void:
	direcao_de_movimento = Input.get_axis("A","D")

