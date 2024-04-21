@icon("res://Assets/Place Holder/Icones/xp.png")
class_name DINHEIRO
extends CharacterBody2D

@onready var textura:AnimatedSprite2D = $Textura
@onready var atualizado_de_quantidade_de_nodos = $AtualizadoDeQuantidadeDeNodos

var interface_pontos:SISTEMA_DE_LEVEL_UP
var dinheiro:float

var nodos_de_dinheiro:Array
var contador_de_dinheiro:int
var dinheiro_limite:int = 100

var liberador_de_movimento:bool = false
var personagem_alvo:PERSONAGEM_BASE
var velocidade_de_movimento:float = 400
var fator_de_aceleracao:float = 0.5

var dinheiro_em_contagem:bool = false

func _ready():
	nodos_de_dinheiro = get_tree().get_nodes_in_group("Dinheiro")
	contador_de_dinheiro = nodos_de_dinheiro.size()
	interface_pontos = find_parent("Nova_Cena_Teste").find_child("InterfaceDeMelhoriaDeAtributo")


func _process(_delta:float) -> void:
	pass

func _physics_process(delta:float) -> void:
	if liberador_de_movimento == true:
		if personagem_alvo.morto == false:
			mover_ate_alvo(delta)
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func mover_ate_alvo(delta:float) -> void:
	var direcao_de_movimento = (personagem_alvo.position - position).normalized()
	var velocidade_alvo = lerp(velocity, direcao_de_movimento * velocidade_de_movimento, 1 - pow(fator_de_aceleracao, delta))
	var distancia_ate_alvo = self.position - personagem_alvo.position
	
	if distancia_ate_alvo.x > 10 || distancia_ate_alvo.x < -10 || distancia_ate_alvo.y > 10 || distancia_ate_alvo.y < -10:
		velocity = velocidade_alvo
	else:
		velocity = Vector2.ZERO
		consumir_dinheiro()

func consumir_dinheiro() -> void:
	interface_pontos.dinheiro_atual += int(dinheiro)
	self.queue_free()

func _on_atualizado_de_quantidade_de_nodos_timeout():
	nodos_de_dinheiro = get_tree().get_nodes_in_group("Dinheiro")
	contador_de_dinheiro = nodos_de_dinheiro.size()
	verificar_se_pode_se_transformar_em_super_dinheiro()

func verificar_se_pode_se_transformar_em_super_dinheiro() -> void:
	if liberador_de_movimento == false:
		if contador_de_dinheiro > dinheiro_limite:
			var valor_temp:float = 0
			if self.name == find_parent("Nova_Cena_Teste").find_child("DinDin").get_child(0).name && dinheiro_em_contagem == false:
				for din in nodos_de_dinheiro:
					valor_temp += din.dinheiro
					dinheiro_em_contagem = true
			
				var super_dinheiro_instancia:DINHEIRO = DATA.CON.Dinheiro.instantiate()
				super_dinheiro_instancia.dinheiro = valor_temp
				super_dinheiro_instancia.position = position
				find_parent("Nova_Cena_Teste").find_child("Itens").find_child("DinDin").add_child(super_dinheiro_instancia)
				super_dinheiro_instancia.atualizar_textura(true)
		
				for money in nodos_de_dinheiro:
					money.queue_free()

func atualizar_textura(super_dinheiro:bool = false) -> void:
	if super_dinheiro == true:
		textura.play("super_dinheiro")
	else:
		textura.play("dinheiro")
