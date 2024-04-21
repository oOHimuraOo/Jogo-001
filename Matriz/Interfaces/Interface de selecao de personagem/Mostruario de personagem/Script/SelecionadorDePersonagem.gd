@icon("res://Assets/Place Holder/Icones/ui.png")
class_name SELECIONADOR_DE_PERSONAGEM
extends Control

@onready var personagem_imagem = $PlanoDeFundo/Centralizador/Organizador/PersonagemImagem
@onready var personagem_nome = $PlanoDeFundo/Centralizador/Organizador/PersonagemNome
@onready var indicador_de_selecao:TextureButton = $IndicadorDeSelecao

var index_do_personagem:String
var nome_do_personagem:String
var imagem_do_personagem:Texture2D
var personagem_selecionado:bool
var interface_pai:INTERFACE_DE_SELECAO_DE_PERSONAGEM

func _ready():
	if nome_do_personagem:
		if imagem_do_personagem:
			inicializar_informacoes()
		else:
			push_error("imagem do personagem não carregada")
	else:
		push_error("nome do personagem não carregado")

func inicializar_informacoes() -> void:
	personagem_nome.set_text(nome_do_personagem)
	personagem_imagem.set_texture(imagem_do_personagem)

func _on_indicador_de_selecao_toggled(toggled_on):
	personagem_selecionado = toggled_on
	if personagem_selecionado == true:
		var personagens = get_tree().get_nodes_in_group("MPers")
		for personagem:SELECIONADOR_DE_PERSONAGEM in personagens:
			if personagem != self && personagem.personagem_selecionado == true:
				personagem.personagem_selecionado = false
				personagem.indicador_de_selecao.toggle_mode = false
			personagem.indicador_de_selecao.toggle_mode = true

func _process(_delta):
	if personagem_selecionado == true:
		interface_pai.personagem_selecionado = self
