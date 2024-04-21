@icon("res://Assets/Place Holder/Icones/ui.png")
class_name INTERFACE_DE_ABERTUAR
extends Control

@onready var botao_jogar = $PlanoDeFundo/Marginalizador/OrganizadorVertical/OrganizadorHorizontal/BotaoJogar
@onready var botao_loja = $PlanoDeFundo/Marginalizador/OrganizadorVertical/OrganizadorHorizontal2/BotaoLoja
@onready var botao_habilidades = $PlanoDeFundo/Marginalizador/OrganizadorVertical/OrganizadorHorizontal2/BotaoHabilidades
@onready var botao_configuracoes = $PlanoDeFundo/Marginalizador/OrganizadorVertical/OrganizadorHorizontal2/BotaoConfiguracoes
@onready var botao_sair = $PlanoDeFundo/Marginalizador/OrganizadorVertical/OrganizadorHorizontal3/BotaoSair
@onready var dinheiro_valor = $PlanoDeFundo/Marginalizador/OrganizadorVertical/Espacador/OrganizadorSuperior/OrganizadorInformativos/DinheiroValor
@onready var presente_valor = $PlanoDeFundo/Marginalizador/OrganizadorVertical/Espacador/OrganizadorSuperior/OrganizadorInformativos/PresenteValor
@onready var altura_valor = $PlanoDeFundo/Marginalizador/OrganizadorVertical/Espacador/OrganizadorSuperior/OrganizadorInformativos/AlturaValor

var altura_total:float
var presente_total:float
var dinheiro_total:float

func _ready():
	carregar_save()
	atualizar_valores()

func carregar_save() -> void:
	pass

func atualizar_valores() -> void:
	dinheiro_valor.set_text(str(dinheiro_total))
	presente_valor.set_text(str(presente_total))
	altura_valor.set_text(str(altura_total))

func _on_botao_jogar_pressed():
	#por enquanto estou instanciando diretamente o jogo. Mas o ideal é instanciar uma tela de seleção de personagem
	#e de lá seguir para uma tela de seleção de fase
	#e só então instanciar a partida de acordo com as diretrizes enviadas pela interfaces anteriores.
	var interface_selecao_personagem = DATA.CON.Interface_De_Selecao_De_Personagem.instantiate()
	interface_selecao_personagem.dinheiro_inicial = dinheiro_total
	interface_selecao_personagem.presente_inicial = presente_total
	interface_selecao_personagem.altura_inicial = altura_total
	get_tree().root.add_child(interface_selecao_personagem)
	self.queue_free()

func _on_botao_loja_pressed():
	pass # Replace with function body.

func _on_botao_habilidades_pressed():
	pass # Replace with function body.

func _on_botao_configuracoes_pressed():
	pass # Replace with function body.

func _on_botao_sair_pressed():
	get_tree().quit()
