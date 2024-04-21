@icon("res://Assets/Place Holder/Icones/xp.png")
class_name IMA
extends CharacterBody2D

@onready var textura:AnimatedSprite2D = $Textura
@onready var atualizado_de_quantidade_de_nodos = $AtualizadoDeQuantidadeDeNodos

var nodos_de_ima:Array
var contador_de_ima:int
var ima_limite:int = 3

var liberador_de_movimento:bool = false
var personagem_alvo:PERSONAGEM_BASE
var velocidade_de_movimento:float = 400
var fator_de_aceleracao:float = 0.5

func _ready():
	nodos_de_ima = get_tree().get_nodes_in_group("Ima")
	contador_de_ima = nodos_de_ima.size()

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
		liberador_de_movimento = false
		ativar_imas()

func ativar_imas() -> void:
	var pontos_de_experiencia:Array = get_tree().get_nodes_in_group("Coletavel")
	for nodos in pontos_de_experiencia:
		nodos.personagem_alvo = personagem_alvo
		nodos.liberador_de_movimento = true
		
	self.queue_free()

func _on_atualizado_de_quantidade_de_nodos_timeout():
	nodos_de_ima = get_tree().get_nodes_in_group("Ima")
	contador_de_ima = nodos_de_ima.size()

