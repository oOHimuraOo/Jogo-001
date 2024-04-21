@icon("res://Assets/Place Holder/Icones/xp.png")
class_name BOMBAS
extends CharacterBody2D

@onready var textura:AnimatedSprite2D = $Textura
@onready var atualizado_de_quantidade_de_nodos = $AtualizadoDeQuantidadeDeNodos
@onready var area_de_dano = $AreaDeDano

var Dano:float = 200

var nodos_de_bombas:Array
var contador_de_bombas:int
var bombas_limite:int = 10

var liberador_de_movimento:bool = false
var personagem_alvo:PERSONAGEM_BASE
var velocidade_de_movimento:float = 400
var fator_de_aceleracao:float = 0.5

func _ready():
	nodos_de_bombas = get_tree().get_nodes_in_group("Bombas")
	contador_de_bombas = nodos_de_bombas.size()

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
		ativar_bombas()

func ativar_bombas() -> void:
	var inimigos_na_area:Array = area_de_dano.get_overlapping_areas()
	for alvos_potenciais:Area2D in inimigos_na_area:
		if alvos_potenciais.is_in_group("Inimigo"):
			alvos_potenciais.get_parent().sistema_de_dano.calculadora_de_dano_de_vida(false,"Fogo",0, Dano)
	iniciar_animacao()

func _on_atualizado_de_quantidade_de_nodos_timeout():
	nodos_de_bombas = get_tree().get_nodes_in_group("Bombas")
	contador_de_bombas = nodos_de_bombas.size()

func iniciar_animacao() -> void:
	textura.play("Explosao")
	await textura.animation_finished
	self.queue_free()
