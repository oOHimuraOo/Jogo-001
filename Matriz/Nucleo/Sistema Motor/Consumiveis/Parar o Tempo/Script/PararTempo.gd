@icon("res://Assets/Place Holder/Icones/xp.png")
class_name PARAR_TEMPO
extends CharacterBody2D

@onready var textura:AnimatedSprite2D = $Textura
@onready var atualizado_de_quantidade_de_nodos:Timer = $AtualizadoDeQuantidadeDeNodos
@onready var tempo_parado:Timer = $TempoParado

var nodos_de_parar_tempo:Array
var contador_de_parar_tempo:int
var parar_tempo_limite:int = 1

var liberador_de_movimento:bool = false
var personagem_alvo:PERSONAGEM_BASE
var velocidade_de_movimento:float = 400
var fator_de_aceleracao:float = 0.5

var pode_parar_tempo:bool = true
var tempo_ja_parado:bool = false
func _ready():
	nodos_de_parar_tempo = get_tree().get_nodes_in_group("Parar_Tempo")
	contador_de_parar_tempo = nodos_de_parar_tempo.size()

func _process(_delta:float) -> void:
	pass

func _physics_process(delta:float) -> void:
	if liberador_de_movimento == true:
		if personagem_alvo.morto == false:
			if tempo_ja_parado == false:
				mover_ate_alvo(delta)
			else:
				velocity = Vector2.ZERO
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
		ativar_parar_tempo()

func ativar_parar_tempo() -> void:
	if pode_parar_tempo == true:
		pode_parar_tempo = false
		tempo_ja_parado = true
		var pontos_de_spawn:Array = get_tree().get_nodes_in_group("Spawn_Point")
		for ponto_de_sawn in pontos_de_spawn:
			ponto_de_sawn.pode_spawnar = false
		
		var inimigos:Array = get_tree().get_nodes_in_group("Inimigo_persona")
		for inimigo:INIMIGO_BASE in inimigos:
			inimigo.pode_atacar = false
			inimigo.pode_mover = false
			
		tempo_parado.start()

func _on_atualizado_de_quantidade_de_nodos_timeout():
	nodos_de_parar_tempo = get_tree().get_nodes_in_group("Parar_Tempo")
	contador_de_parar_tempo = nodos_de_parar_tempo.size()

func _on_tempo_parado_timeout():
	var pontos_de_spawn:Array = get_tree().get_nodes_in_group("Spawn_Point")
	for ponto_de_sawn in pontos_de_spawn:
		ponto_de_sawn.pode_spawnar = true
		ponto_de_sawn.cooldown_do_spawn.start()
	
	var inimigos:Array = get_tree().get_nodes_in_group("Inimigo_persona")
	for inimigo:INIMIGO_BASE in inimigos:
		inimigo.pode_atacar = true
		inimigo.pode_mover = true
	
	self.queue_free()
