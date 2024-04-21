class_name BARRA_DE_VIDA
extends Control

signal vida_zerada(entidade)
signal vida_recuperada(entidade, valor)

@onready var icone_vida:TextureRect = $Organizador/IconeVida
@onready var barra_vida:TextureProgressBar = $Organizador/BarraVida
@onready var dono_da_vida:CharacterBody2D = get_parent().get_parent()

var vida_atual:float = 100.0
var vida_maxima:float = 100.0
var vida_percentual:int = 0

var inimigo:bool = false

func _ready():
	carregar_info_inicial_de_vida()

func carregar_info_inicial_de_vida() -> void:
	if inimigo == false:
		vida_maxima = dono_da_vida.valores_do_jogador.vida_incial
		vida_atual = vida_maxima
		atualizar_barra_de_vida()
	else:
		vida_maxima = dono_da_vida.valores_do_inimigo.vida_incial
		vida_atual = vida_maxima
		atualizar_barra_de_vida()

func atualizar_barra_de_vida() -> void:
	vida_percentual = int(round((vida_atual / vida_maxima) * 100))
	barra_vida.value = vida_percentual
	atualizador_de_cor_da_barra()

func atualizador_de_cor_da_barra() -> void:
	if vida_percentual > 66:
		barra_vida.tint_progress = DATA.DIC.Cores["barra_de_vida"]["cheio"]
	if vida_percentual <= 66:
		barra_vida.tint_progress = DATA.DIC.Cores["barra_de_vida"]["medio"]
	if vida_percentual < 33:
		barra_vida.tint_progress = DATA.DIC.Cores["barra_de_vida"]["vazio"]

func ganhar_vida(valor:float) -> void:
	vida_atual += valor
	if vida_atual > vida_maxima:
		vida_atual = vida_maxima
	elif valor + vida_atual > vida_maxima:
		vida_atual = vida_maxima
		emit_signal("vida_recuperada", dono_da_vida, vida_maxima - vida_atual)
	else:
		emit_signal("vida_recuperada", dono_da_vida, valor)
	atualizar_barra_de_vida()

func perder_vida(valor:float) -> void:
	vida_atual -= valor
	if vida_atual <= 0:
		vida_atual = 0
		emit_signal("vida_zerada", dono_da_vida)
	atualizar_barra_de_vida()
