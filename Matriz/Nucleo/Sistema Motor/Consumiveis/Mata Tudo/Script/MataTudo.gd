@icon("res://Assets/Place Holder/Icones/xp.png")
class_name MATAR_TUDO
extends CharacterBody2D

@onready var textura:AnimatedSprite2D = $Textura
@onready var atualizado_de_quantidade_de_nodos:Timer = $AtualizadoDeQuantidadeDeNodos

var nodos_de_matar_tudo:Array
var contador_de_matar_tudo:int
var matar_tudo_limite:int = 10

var liberador_de_movimento:bool = false
var personagem_alvo:PERSONAGEM_BASE
var velocidade_de_movimento:float = 400
var fator_de_aceleracao:float = 0.5

func _ready():
	nodos_de_matar_tudo = get_tree().get_nodes_in_group("Mata_Tudo")
	contador_de_matar_tudo = nodos_de_matar_tudo.size()

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
		ativar_mata_tudo()
	

func ativar_mata_tudo() -> void:
	var inimigos:Array = get_tree().get_nodes_in_group("Inimigo_persona")
	for inimigo:INIMIGO_BASE in inimigos:
		inimigo.sistema_de_dano.calculadora_de_dano_de_vida(false,"Fogo",999999,999999)
	self.queue_free()

func _on_atualizado_de_quantidade_de_nodos_timeout():
	nodos_de_matar_tudo = get_tree().get_nodes_in_group("Mata_Tudo")
	contador_de_matar_tudo = nodos_de_matar_tudo.size()


