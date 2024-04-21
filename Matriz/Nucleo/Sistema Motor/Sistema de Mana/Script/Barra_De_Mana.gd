class_name BARRA_DE_MANA
extends Control

signal mana_zerada(entidade)
signal mana_recuperada(entidade, valor)

@onready var icone_mana:TextureRect = $Organizador/IconeMana
@onready var barra_mana:TextureProgressBar = $Organizador/BarraMana
@onready var dono_da_mana:CharacterBody2D = get_parent().get_parent()

var mana_atual:float = 100.0
var mana_maxima:float = 100.0
var mana_percentual:int = 0


func _ready():
	carregar_info_inicial_de_mana()

func carregar_info_inicial_de_mana() -> void:
	mana_maxima = dono_da_mana.valores_do_jogador.mana_incial
	mana_atual = mana_maxima
	atualizar_barra_de_mana()


func atualizar_barra_de_mana() -> void:
	mana_percentual = int(round((mana_atual / mana_maxima) * 100))
	barra_mana.value = mana_percentual
	atualizador_de_cor_da_barra()

func atualizador_de_cor_da_barra() -> void:
	if mana_percentual > 66:
		barra_mana.tint_progress = DATA.DIC.Cores["barra_de_mana"]["cheio"]
	if mana_percentual <= 66:
		barra_mana.tint_progress = DATA.DIC.Cores["barra_de_mana"]["medio"]
	if mana_percentual < 33:
		barra_mana.tint_progress = DATA.DIC.Cores["barra_de_mana"]["vazio"]

func ganhar_mana(valor:float) -> void:
	mana_atual += valor
	emit_signal("mana_recuperada", dono_da_mana, valor)
	if mana_atual > mana_maxima:
		mana_atual = mana_maxima
	atualizar_barra_de_mana()

func perder_mana(valor:float) -> void:
	mana_atual -= valor
	if mana_atual <= 0:
		mana_atual = 0
		emit_signal("mana_zerada", dono_da_mana)
	atualizar_barra_de_mana()
