@icon("res://Assets/Place Holder/Icones/pullandpush.png")
class_name PULL_AND_PUSH
extends Node

var cemiterio_de_inimigos:Vector2
var cemiterio_de_letras:Vector2
var cemiterio_de_quebraveis:Vector2
var cemiterio_de_xp:Vector2
var cemiterio_de_consumiveis:Vector2

var ponto_de_destino_inimigos:Vector2
var ponto_de_destino_letras:Vector2
var ponto_de_destino_quebraveis:Vector2
var ponto_de_destino_xp:Vector2
var ponto_de_destino_consumiveis:Vector2


func _ready():
	aplicar_informacoes_basicas(randi_range(0,10))

func aplicar_informacoes_basicas(index:int) -> void:
	cemiterio_de_inimigos = 
	cemiterio_de_letras
	cemiterio_de_quebraveis
	cemiterio_de_xp
	cemiterio_de_consumiveis

	ponto_de_destino_inimigos
	ponto_de_destino_letras
	ponto_de_destino_quebraveis
	ponto_de_destino_xp
	ponto_de_destino_consumiveis

func iniciar_spawn_inicial() -> void:
	pass
