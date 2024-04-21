class_name BARRA_DE_ESTAMINA
extends Control

signal estamina_zerada(entidade)
signal estamina_recuperada(entidade, valor)

@onready var icone_estamina:TextureRect = $Organizador/IconeEstamina
@onready var barra_estamina:TextureProgressBar = $Organizador/BarraEstamina
@onready var dono_da_estamina:CharacterBody2D = get_parent().get_parent()

var estamina_atual:float = 100.0
var estamina_maxima:float = 100.0
var estamina_percentual:int = 0

func _ready():
	carregar_info_inicial_de_estamina()

func carregar_info_inicial_de_estamina() -> void:
	estamina_maxima = dono_da_estamina.valores_do_jogador.estamina_incial
	estamina_atual = estamina_maxima
	atualizar_barra_de_estamina()

func atualizar_barra_de_estamina() -> void:
	estamina_percentual = int(round((estamina_atual / estamina_maxima) * 100))
	barra_estamina.value = estamina_percentual
	atualizador_de_cor_da_barra()

func atualizador_de_cor_da_barra() -> void:
	if estamina_percentual > 66:
		barra_estamina.tint_progress = DATA.DIC.Cores["barra_de_estamina"]["cheio"]
	if estamina_percentual <= 66:
		barra_estamina.tint_progress = DATA.DIC.Cores["barra_de_estamina"]["medio"]
	if estamina_percentual < 33:
		barra_estamina.tint_progress = DATA.DIC.Cores["barra_de_estamina"]["vazio"]

func ganhar_estamina(valor:float) -> void:
	estamina_atual += valor
	emit_signal("estamina_recuperada", dono_da_estamina, valor)
	if estamina_atual > estamina_maxima:
		estamina_atual = estamina_maxima
	atualizar_barra_de_estamina()

func perder_estamina(valor:float) -> void:
	estamina_atual -= valor
	if estamina_atual <= 0:
		estamina_atual = 0
		emit_signal("estamina_zerada", dono_da_estamina)
	atualizar_barra_de_estamina()
