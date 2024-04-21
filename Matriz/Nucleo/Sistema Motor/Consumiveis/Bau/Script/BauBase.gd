@icon("res://Assets/Place Holder/Icones/Sprite-0001.png")
class_name BAU_BASE
extends RigidBody2D

@onready var textura = $Textura
@onready var detector_de_mouse = $DetectorDeMouse

var lista_de_consumiveis_possiveis:Array

var quantidade_maxima_de_itens_dropados:int
var quantidade_atual_de_itens_dropados:int

var multiplicador_de_valor_do_item_dropado:float = 5
var valor_do_item_dropado:float

var aberto:bool = false
var detector_de_click:bool = false

func _ready():
	randomize()
	atualizar_listas()
	aleatorizar_quantidade_maxima_de_itens_dropados()
	calcular_valor_do_multiplicador_de_valor()
	calcular_valor_final()

func atualizar_listas() -> void:
	var itens = find_parent("Nova_Cena_Teste").find_child("Itens")
	for filho in itens.get_children():
		if filho.name == "Consumiveis":
			if filho.get_child_count() != 0:
				for item in filho.get_children():
					if item is BOMBAS:
						item._on_atualizado_de_quantidade_de_nodos_timeout()
						if item.contador_de_bombas < item.bombas_limite:
							if !lista_de_consumiveis_possiveis.has("Bombas"):
								lista_de_consumiveis_possiveis += ["Bombas"]
					elif item is MATAR_TUDO:
						item._on_atualizado_de_quantidade_de_nodos_timeout()
						if item.contador_de_matar_tudo < item.matar_tudo_limite:
							if !lista_de_consumiveis_possiveis.has("Matar_Tudo"):
								lista_de_consumiveis_possiveis += ["Matar_Tudo"]
					elif item is PARAR_TEMPO:
						item._on_atualizado_de_quantidade_de_nodos_timeout()
						if item.contador_de_parar_tempo < item.parar_tempo_limite:
							if !lista_de_consumiveis_possiveis.has("Parar_Tempo"):
								lista_de_consumiveis_possiveis += ["Parar_Tempo"]
					elif item is POCOES:
						item._on_atualizado_de_quantidade_de_nodos_timeout()
						if item.contador_de_pocoes < item.pocoes_limite:
							if !lista_de_consumiveis_possiveis.has("Pocoes"):
								lista_de_consumiveis_possiveis += ["Pocoes"]
					elif item is IMA:
						item._on_atualizado_de_quantidade_de_nodos_timeout()
						if item.contador_de_ima < item.ima_limite:
							if !lista_de_consumiveis_possiveis.has("Ima"):
								lista_de_consumiveis_possiveis += ["Ima"]
			else:
				lista_de_consumiveis_possiveis = ["Ima", "Pocoes", "Parar_Tempo", "Matar_Tudo", "Bombas"]
		
func aleatorizar_quantidade_maxima_de_itens_dropados() -> void:
	if lista_de_consumiveis_possiveis.size() > 3:
		quantidade_maxima_de_itens_dropados = randi_range(2,5)
	else:
		quantidade_maxima_de_itens_dropados = randi_range(1,3)

func calcular_valor_do_multiplicador_de_valor() -> void:
	var tamanho = lista_de_consumiveis_possiveis.size()
	multiplicador_de_valor_do_item_dropado = multiplicador_de_valor_do_item_dropado - (tamanho)

func calcular_valor_final() -> void:
	valor_do_item_dropado = randi_range(50,100) * multiplicador_de_valor_do_item_dropado

func quando_consumido() -> void:
	for quantidade in quantidade_maxima_de_itens_dropados:
		if lista_de_consumiveis_possiveis.size() != 0:
			instanciar_itens()
		if valor_do_item_dropado != 0:
			instanciar_dinheiro()
			break

func instanciar_itens() -> void:
	var item = lista_de_consumiveis_possiveis.pick_random()
	match item:
		"Bombas":
			var bombas_instancia = DATA.CON.Bomba.instantiate()
			bombas_instancia.global_position = global_position + Vector2(20,0)
			find_parent("Nova_Cena_Teste").find_child("Itens").find_child("Consumiveis").add_child(bombas_instancia)
		"Matar_Tudo":
			var mata_tudo_instancia = DATA.CON.Mata_Tudo.instantiate()
			mata_tudo_instancia.global_position = global_position + Vector2(40,0)
			find_parent("Nova_Cena_Teste").find_child("Itens").find_child("Consumiveis").add_child(mata_tudo_instancia)
		"Parar_Tempo":
			var parar_tempo_instancia = DATA.CON.Parar_Tempo.instantiate()
			parar_tempo_instancia.global_position = global_position
			find_parent("Nova_Cena_Teste").find_child("Itens").find_child("Consumiveis").add_child(parar_tempo_instancia)
		"Pocoes":
			var tipos_de_pocoes:Array = ["Pocao_Vida_Pequena", "Pocao_Vida_Media", "Pocao_Vida_Grande", "Pocao_Mana_Pequena", "Pocao_Mana_Media", "Pocao_Mana_Grande", "Pocao_Estamina_Pequena", "Pocao_Estamina_Media", "Pocao_Estamina_Grande"]
			var pocoes_instancia = DATA.CON.get(tipos_de_pocoes.pick_random()).instantiate()
			pocoes_instancia.global_position = global_position - Vector2(20,0)
			find_parent("Nova_Cena_Teste").find_child("Itens").find_child("Consumiveis").add_child(pocoes_instancia)
		"Ima":
			var ima_instancia = DATA.CON.Ima.instantiate()
			ima_instancia.global_position = global_position - Vector2(40,0)
			find_parent("Nova_Cena_Teste").find_child("Itens").find_child("Consumiveis").add_child(ima_instancia)

func instanciar_dinheiro() -> void:
	var dinheiro_instancia:DINHEIRO = DATA.CON.Dinheiro.instantiate()
	dinheiro_instancia.dinheiro = valor_do_item_dropado
	dinheiro_instancia.position = position + Vector2(60,0)
	find_parent("Nova_Cena_Teste").find_child("Itens").find_child("DinDin").add_child(dinheiro_instancia)

func _on_textura_animation_finished():
	self.queue_free()

func _on_detector_de_mouse_mouse_entered():
	detector_de_click = true

func _on_detector_de_mouse_mouse_exited():
	detector_de_click = false

func _process(_delta):
	if detector_de_click == true:
		var personagem:PERSONAGEM_BASE = find_parent("Nova_Cena_Teste").find_child("Personagem").get_child(0)
		if Input.is_action_just_pressed("Atirar"):
			if personagem.maquina_de_estados.get_child(0).name == personagem.maquina_de_estados.estado_ativo.get_parent().name or personagem.maquina_de_estados.get_child(2).name == personagem.maquina_de_estados.estado_ativo.get_parent().name:
				quando_consumido()
				textura.play("Abrindo")
