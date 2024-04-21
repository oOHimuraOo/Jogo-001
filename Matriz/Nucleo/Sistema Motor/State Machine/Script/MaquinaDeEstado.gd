class_name MAQUINA_DE_ESTADO
extends Node

var personagem:CharacterBody2D
var animacao:AnimatedSprite2D
var estado_ativo:ESTADO_BASE

func verificar_e_inicializar_maquina_de_estado() -> void:
	for Zona in get_children():
		for nodo in Zona.get_children():
			if nodo is ESTADO_BASE:
				nodo.MDE = self
				nodo.Dono_do_estado = personagem
				nodo.Animacao = animacao
				continue
			else:
				push_error(nodo.name," não é um estado valido")
				nodo.queue_free()
	
	estado_ativo = get_child(0).get_child(0)
	estado_ativo.ao_entrar_no_estado()

func _process(delta):
	if estado_ativo != null:
		estado_ativo.no_process(delta)

func _physics_process(delta):
	if estado_ativo != null:
		estado_ativo.no_physics_process(delta)

func mudar_estado_ativo(Estilo:String, Novo_Estado:String, info:Dictionary = {}) -> void:
	if !find_child(Estilo).has_node(Novo_Estado):
		push_error(Novo_Estado, " não é um estado do personagem")
	else:
		estado_ativo.ao_sair_do_estado(info)
		estado_ativo = find_child(Estilo).get_node(Novo_Estado) as ESTADO_BASE
		estado_ativo.ao_entrar_no_estado(info)
