class_name BARRA_DE_EXPERIENCIA
extends Control

signal experiencia_zerada(entidade)
signal experiencia_recuperada(entidade, valor)

@onready var icone_experiencia:TextureRect = $Organizador/IconeExperiencia
@onready var barra_experiencia:TextureProgressBar = $Organizador/BarraExperiencia
@onready var dono_da_experiencia:CharacterBody2D = get_parent().get_parent()

var experiencia_atual:float = 0
var experiencia_maxima:float = 100.0
var experiencia_percentual:int = 0

var valor_arbitrario:float = 41.25
var multiplicador_padrao:float = 10

var personagem:PERSONAGEM_BASE

func _ready():
	carregar_info_inicial_de_experiencia()

func carregar_info_inicial_de_experiencia() -> void:
	calcular_experiencia_maxima()
	atualizar_barra_de_experiencia()

func atualizar_barra_de_experiencia() -> void:
	experiencia_percentual = int(round((experiencia_atual / experiencia_maxima) * 100))
	barra_experiencia.value = experiencia_percentual
	atualizador_de_cor_da_barra()

func atualizador_de_cor_da_barra() -> void:
	if experiencia_percentual > 66:
		barra_experiencia.tint_progress = DATA.DIC.Cores["barra_de_experiencia"]["vazio"]
	if experiencia_percentual <= 66:
		barra_experiencia.tint_progress = DATA.DIC.Cores["barra_de_experiencia"]["medio"]
	if experiencia_percentual < 33:
		barra_experiencia.tint_progress = DATA.DIC.Cores["barra_de_experiencia"]["cheio"]

func ganhar_experiencia(valor:float) -> void:
	if valor < experiencia_maxima - experiencia_atual:
		experiencia_atual += valor
	elif valor == experiencia_maxima - experiencia_atual:
		experiencia_atual = 0
		aumentar_nivel()
		calcular_experiencia_maxima()
	elif valor > experiencia_maxima - experiencia_atual:
		var exp_temp = valor - (experiencia_maxima - experiencia_atual)
		experiencia_atual = 0
		aumentar_nivel()
		calcular_experiencia_maxima()
		ganhar_experiencia(exp_temp)
	
	atualizar_barra_de_experiencia()

func aumentar_nivel() -> void:
	personagem.valores_do_jogador.nivel += 1
	personagem.regulador_do_jogador.subir_de_nivel()
	ativando_interface_de_level_up()

func ativando_interface_de_level_up() -> void:
	var interface_de_level_up:SISTEMA_DE_LEVEL_UP = find_parent("Nova_Cena_Teste").find_child("InterfaceDeMelhoriaDeAtributo")
	var camera:CAMERA_CONTROLE = find_parent("Nova_Cena_Teste").find_child("Camera").get_child(0)
	interface_de_level_up.subiu_de_nivel = true
	interface_de_level_up.pontos_disponiveis += 5
	interface_de_level_up.atualizar_informacoes_finais()
	interface_de_level_up.show()
	camera.enabled = false

func calcular_experiencia_maxima() -> void:
	experiencia_maxima = (valor_arbitrario * multiplicador_padrao) * personagem.valores_do_jogador.nivel
	
