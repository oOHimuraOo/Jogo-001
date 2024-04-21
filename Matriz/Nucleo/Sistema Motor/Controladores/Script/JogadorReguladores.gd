class_name REGULADOR_DOS_JOGADORES
extends Node

var personagem:PERSONAGEM_BASE

var tempo_limite_de_efeito_coyote:float = 30
var ultima_vez_chao:float = 0

var regulador_de_tempo_de_pulo:float = 30
var ultima_vez_pulo_apertado:float = 0
var valor_arbitrario:float = 10

func _input(_event):
	if Input.is_action_just_pressed("ui_accept"):
		ultima_vez_pulo_apertado = Time.get_ticks_msec()

func _physics_process(_delta):
	if personagem.is_on_floor():
		ultima_vez_chao = Time.get_ticks_msec()

func subir_de_nivel():
	var taxa_de_regeneracao_vida:float = (personagem.valores_do_jogador.constituicao + valor_arbitrario)
	var valor_recuperado_vida:float = (taxa_de_regeneracao_vida/100) * personagem.barra_de_vida.vida_maxima
	var taxa_de_regeneracao_mana:float = (personagem.valores_do_jogador.destreza + valor_arbitrario)
	var valor_recuperado_mana:float = (taxa_de_regeneracao_mana/100) * personagem.barra_de_mana.mana_maxima
	var taxa_de_regeneracao_estamina:float = (personagem.valores_do_jogador.forca + valor_arbitrario)
	var valor_recuperado_estamina:float = (taxa_de_regeneracao_estamina/100) * personagem.barra_de_estamina.estamina_maxima
	personagem.barra_de_vida.ganhar_vida(valor_recuperado_vida)
	personagem.barra_de_mana.ganhar_mana(valor_recuperado_mana)
	personagem.barra_de_estamina.ganhar_estamina(valor_recuperado_estamina)
	#personagem.Sistema_de_melhoria_de_atributos.iniciar_interface()
