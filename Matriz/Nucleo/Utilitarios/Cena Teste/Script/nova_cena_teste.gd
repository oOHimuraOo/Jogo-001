class_name GERENCIADOR_DE_JOGO
extends Node

@onready var interface_de_melhoria_de_atributo = $Interfaces/InterfaceDeMelhoriaDeAtributo
@onready var camera = $Camera

var dinheiro_inicial:float
var presente_inicial:float
var altura_inicial:float
var index_do_personagem:int

func _input(_event):
	if Input.is_action_just_pressed("ESC"):
		if !interface_de_melhoria_de_atributo.is_visible_in_tree():
			interface_de_melhoria_de_atributo.subiu_de_nivel = false
			interface_de_melhoria_de_atributo.atualizar_informacoes_finais()
			interface_de_melhoria_de_atributo.liberar_ou_travar_botoes_de_alteracao_de_atributos()
			interface_de_melhoria_de_atributo.show()
			camera.get_child(0).enabled = false
	if Input.is_action_just_pressed("1"):
		var bau_cena = load("res://Matriz/Nucleo/Sistema Motor/Consumiveis/Bau/Cena/BauBase.tscn")
		var bau_instancia = bau_cena.instantiate()
		bau_instancia.global_position = Vector2(300,-150)
		add_child(bau_instancia)

func _process(_delta):
	if interface_de_melhoria_de_atributo.is_visible_in_tree():
		await get_tree().create_timer(0.01).timeout
		get_tree().paused = true
