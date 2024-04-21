@icon("res://Assets/Place Holder/Icones/xp.png")
class_name PONTOS_DE_EXPERIENCIA
extends CharacterBody2D

@onready var textura = $Textura
@onready var atualizador_de_valor_de_experiencia = $Atualizador_de_valor_de_experiencia

var xp_inicial:float
var xp_atual:float

var limite_de_xp:int = 300

var nodos_de_xp:Array
var contador_de_xp:int

var liberador_de_movimento:bool = false
var personagem_alvo:PERSONAGEM_BASE
var velocidade_de_movimento:float = 400
var fator_de_aceleracao:float = 0.5

var xp_em_contagem:bool = false
var super_xp:bool = false

func _ready():
	nodos_de_xp = get_tree().get_nodes_in_group("Xp")
	contador_de_xp = nodos_de_xp.size()
	atualizador_de_textura()

func _process(_delta:float) -> void:
	if contador_de_xp >= limite_de_xp && atualizador_de_valor_de_experiencia.is_stopped():
		atualizador_de_valor_de_experiencia.start()
		atualizador_de_textura()

func _physics_process(delta:float) -> void:
	if liberador_de_movimento == true:
		if personagem_alvo.morto == false:
			mover_ate_alvo(delta)

func atualizador_de_textura() -> void:
	if super_xp == false:
		if xp_atual < xp_inicial*5:
			textura.set_texture(DATA.CON.Xp_Fraca)
		if xp_atual >= xp_inicial*5:
			textura.set_texture(DATA.CON.Xp_Medio)
		if xp_atual >= xp_inicial*10:
			textura.set_texture(DATA.CON.Xp_Forte)
	if super_xp == true:
		textura.set_texture(DATA.CON.Xp_Muito_Forte)

func _on_atualizador_de_valor_de_experiencia_timeout() -> void:
	xp_atual += xp_inicial

func _on_atualizador_de_quantidade_de_nodos_timeout():
	nodos_de_xp = get_tree().get_nodes_in_group("Xp")
	contador_de_xp = nodos_de_xp.size()
	verificar_se_pode_se_transformar_em_super_xp()

func verificar_se_pode_se_transformar_em_super_xp() -> void:
	if liberador_de_movimento == false:
		if contador_de_xp > limite_de_xp:
			var valor_temp:float = 0
			if self.name == find_parent("Nova_Cena_Teste").find_child("Xp").get_child(0).name && xp_em_contagem == false:
				for xp in nodos_de_xp:
					valor_temp += xp.xp_inicial
					xp_em_contagem = true
			
				var super_xp_instancia:PONTOS_DE_EXPERIENCIA = DATA.CON.Xp.instantiate()
				super_xp_instancia.xp_inicial = valor_temp
				super_xp_instancia.position = position
				super_xp_instancia.super_xp = true
				find_parent("Nova_Cena_Teste").find_child("Itens").find_child("Xp").add_child(super_xp_instancia)
		
				for xp in nodos_de_xp:
					xp.queue_free()

func mover_ate_alvo(delta:float) -> void:
	var direcao_de_movimento = (personagem_alvo.position - position).normalized()
	var velocidade_alvo = lerp(velocity, direcao_de_movimento * velocidade_de_movimento, 1 - pow(fator_de_aceleracao, delta))
	var distancia_ate_alvo = self.position - personagem_alvo.position
	
	if distancia_ate_alvo.x > 10 || distancia_ate_alvo.x < -10 || distancia_ate_alvo.y > 10 || distancia_ate_alvo.y < -10:
		velocity = velocidade_alvo
	else:
		velocity = Vector2.ZERO
		liberador_de_movimento = false
		consumir_xp()
	
	move_and_slide()

func consumir_xp() -> void:
	personagem_alvo.barra_de_experiencia.ganhar_experiencia(xp_atual)
	self.queue_free()
