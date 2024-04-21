class_name VALORES_DO_JOGADOR
extends Node

var personagem:PERSONAGEM_BASE

var velocidade_de_movimento:float = 125
var velocidade_de_movimento_em_combate:float = 140
var velocidade_de_movimento_mirando:float = 70

var fator_de_aceleracao:float = 0.03
var fator_de_aceleracao_aeria:float = 0.01
var fator_de_desaleracao:float = 0

var altura_do_pulo:int = 100
var altura_extra_do_pulo:int = 75
var tempo_ate_altura_maxima_do_pulo:float = 0.5

var gravidade_calculada:float = 0
var gravidade_de_queda_acelerada:float = 0
var velocidade_de_pulo:float = 0
var velocidade_do_pulo_extra:float = 0

var nivel:int
var vida_incial:float
var mana_incial:float
var estamina_incial:float
var forca:float
var destreza:float
var constituicao:float
var quantidade_de_pulos:int
var lista_de_estados:Array
var resistencias:Array
var fraquezas:Array
var area_de_coleta:float


func _ready() -> void:
	calcular_valores_de_pulo()

func calcular_valores_de_pulo() -> void:
	velocidade_de_pulo = -(altura_do_pulo * 2) / tempo_ate_altura_maxima_do_pulo
	velocidade_do_pulo_extra = -(altura_extra_do_pulo * 2) / tempo_ate_altura_maxima_do_pulo
	gravidade_calculada = (altura_do_pulo * 2) / pow(tempo_ate_altura_maxima_do_pulo, 2)
	gravidade_de_queda_acelerada = gravidade_calculada * 4

