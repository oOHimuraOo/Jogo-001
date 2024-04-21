@icon("res://Assets/Place Holder/Icones/ui.png")
class_name INTERFACE_DE_SELECAO_DE_PERSONAGEM
extends Control

@onready var vida_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorVida/VidaValor
@onready var mana_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorMana/ManaValor
@onready var estamina_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorEstamina/EstaminaValor
@onready var forca_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorForca/ForcaValor
@onready var destreza_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorDestreza/DestrezaValor
@onready var constituicao_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorConstituicao/ConstituicaoValor
@onready var pulos_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorPulos/PulosValor
@onready var velocidade_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorVelocidade/VelocidadeValor
@onready var sorte_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorSorte/SorteValor
@onready var arma_imagem:TextureRect = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorArma/ArmaImagem
@onready var arma_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorArma/ArmaValor
@onready var habilidade_1_imagem:TextureRect = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade1/Habilidade1Imagem
@onready var habilidade_1_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade1/Habilidade1Valor
@onready var habilidade_2_imagem:TextureRect = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade2/Habilidade2Imagem
@onready var habilidade_2_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade2/Habilidade2Valor
@onready var habilidade_3_imagem:TextureRect = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade3/Habilidade3Imagem
@onready var habilidade_3_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade3/Habilidade3Valor
@onready var habilidade_4_imagem:TextureRect = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade4/Habilidade4Imagem
@onready var habilidade_4_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade4/Habilidade4Valor
@onready var habilidade_5_imagem:TextureRect = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade5/Habilidade5Imagem
@onready var habilidade_5_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade5/Habilidade5Valor
@onready var habilidade_6_imagem:TextureRect = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade6/Habilidade6Imagem
@onready var habilidade_6_valor:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/OrganizadorHabilidade6/Habilidade6Valor
@onready var video_demonstrativo_personagem:VideoStreamPlayer = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorVertical/PlanoDeFundo/Centralizador/VideoDemonstrativoPersonagem
@onready var organizador_de_grid:GridContainer = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorSelecaoPersonagens/OrganizadorDeScroll/OrganizadorDeGrid
@onready var retrato_imagem:TextureRect = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorSelecaoPersonagens/OrganizadorDeDescritivo/PlanoDeFundo/Marginalizador/OrganizadorHorizontal/PlanoDeFundoRetrato/Marginalizador/RetratoImagem
@onready var titulo_do_descritivo:Label = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorSelecaoPersonagens/OrganizadorDeDescritivo/PlanoDeFundo/Marginalizador/OrganizadorHorizontal/AtivadorDeScroll/OrganizadorVertical/TituloDoDescritivo
@onready var texto_descricao:RichTextLabel = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorSelecaoPersonagens/OrganizadorDeDescritivo/PlanoDeFundo/Marginalizador/OrganizadorHorizontal/AtivadorDeScroll/OrganizadorVertical/TextoDescricao
@onready var botao_confirmar:TextureButton = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorSelecaoPersonagens/OrganizadorHorizontal/BotaoConfirmar
@onready var botao_cancelar:TextureButton = $PlanoDeFundo/Marginalizador/OrganizadorHorizontal/OrganizadorSelecaoPersonagens/OrganizadorHorizontal/BotaoCancelar

var personagem_selecionado:SELECIONADOR_DE_PERSONAGEM
var dinheiro_inicial:float
var presente_inicial:float
var altura_inicial:float

func _ready():
	carregar_personagens()

func carregar_personagens() -> void:
	for index in DATA.DAT.DTB_PERS:
		var selecionador_instancia = DATA.CON.Selecionador_De_Personagem.instantiate()
		selecionador_instancia.index_do_personagem = index
		selecionador_instancia.nome_do_personagem = DATA.DAT.DTB_PERS[index]["Nome"]
		selecionador_instancia.imagem_do_personagem = load("res://icon.svg")
		selecionador_instancia.interface_pai = self
		organizador_de_grid.add_child(selecionador_instancia)

func _process(_delta):
	if personagem_selecionado:
		botao_confirmar.set_disabled(false)
		carregar_informacao_de_personagem_selecionado()
	else:
		botao_confirmar.set_disabled(true)

func carregar_informacao_de_personagem_selecionado() -> void:
	vida_valor.set_text(str(DATA.DAT.DTB_PERS[personagem_selecionado.index_do_personagem]["Vida"]))
	mana_valor.set_text(str(DATA.DAT.DTB_PERS[personagem_selecionado.index_do_personagem]["Mana"]))
	estamina_valor.set_text(str(DATA.DAT.DTB_PERS[personagem_selecionado.index_do_personagem]["Estamina"]))
	forca_valor.set_text(str(DATA.DAT.DTB_PERS[personagem_selecionado.index_do_personagem]["Forca"]))
	destreza_valor.set_text(str(DATA.DAT.DTB_PERS[personagem_selecionado.index_do_personagem]["Destreza"]))
	constituicao_valor.set_text(str(DATA.DAT.DTB_PERS[personagem_selecionado.index_do_personagem]["Constituicao"]))
	pulos_valor.set_text(str(DATA.DAT.DTB_PERS[personagem_selecionado.index_do_personagem]["Pulos"]))


func _on_botao_confirmar_pressed():
	var cena_teste_instancia = DATA.CON.Cena_Teste.instantiate()
	cena_teste_instancia.dinheiro_inicial = dinheiro_inicial
	cena_teste_instancia.presente_inicial = presente_inicial
	cena_teste_instancia.altura_inicial = altura_inicial
	cena_teste_instancia.index_do_personagem = personagem_selecionado.index_do_personagem
	get_tree().root.add_child(cena_teste_instancia)
	self.queue_free()

func _on_botao_cancelar_pressed():
	var interface_abertura_instancia = DATA.CON.Interface_De_Abertura.instantiate()
	interface_abertura_instancia.altura_total = dinheiro_inicial
	interface_abertura_instancia.presente_total = presente_inicial
	interface_abertura_instancia.dinheiro_total = altura_inicial
	get_tree().root.add_child(interface_abertura_instancia)
	self.queue_free()
