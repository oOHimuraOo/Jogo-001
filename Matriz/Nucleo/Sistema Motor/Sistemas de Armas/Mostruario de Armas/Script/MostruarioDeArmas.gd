@icon("res://Assets/Place Holder/Icones/Ak47.png")
class_name MOSTRUARIO_DE_ARMAS
extends Control

@onready var botao_plano_de_fundo:TextureButton = $BotaoPlanoDeFundo
@onready var etiqueta_nome:Label = $Organizador/EtiquetaNome
@onready var etiqueta_nivel_valor:Label = $Organizador/Organizador/EtiquetaNivelValor

var nome:String
var nivel_valor:int
var textura:Texture2D

var tipo_de_slot:String
var slot_atual:int
var interface_de_level_up:SISTEMA_DE_LEVEL_UP

func _ready():
	if tipo_de_slot == "Ativas":
		verificar_modificacoes_nas_informacoes(interface_de_level_up.lista_de_armas_ativas[str(slot_atual)]["Nome"])
	elif tipo_de_slot == "Passivas":
		verificar_modificacoes_nas_informacoes(interface_de_level_up.lista_de_armas_passivas[str(slot_atual)]["Nome"])
	elif tipo_de_slot == "Habilidades":
		verificar_modificacoes_nas_informacoes(interface_de_level_up.lista_de_habilidades[str(slot_atual)]["Nome"])

func verificar_modificacoes_nas_informacoes(Novo_nome:String) -> void:
	if Novo_nome != nome:
		nome = Novo_nome
		textura = DATA.CON.get(nome + "_Mostruario")
		if tipo_de_slot == "Ativas":
			nivel_valor = interface_de_level_up.lista_de_armas_ativas[str(slot_atual)]["Nivel"]
		elif tipo_de_slot == "Passivas":
			nivel_valor = interface_de_level_up.lista_de_armas_passivas[str(slot_atual)]["Nivel"]
		elif tipo_de_slot == "Habilidades":
			nivel_valor = interface_de_level_up.lista_de_habilidades[str(slot_atual)]["Nivel"]
	
	atualizar_informacoes()

func atualizar_informacoes() -> void:
	etiqueta_nome.set_text(nome)
	botao_plano_de_fundo.texture_normal = textura
	etiqueta_nivel_valor.set_text(str(nivel_valor))

func _process(_delta):
	if interface_de_level_up.arrastando_item == true:
		if Input.is_action_just_released("Atirar"):
			interface_de_level_up.arrastando_item = false
			interface_de_level_up.corrigir_posicao()

func _on_botao_plano_de_fundo_button_down():
	interface_de_level_up.arrastando_item = true
	interface_de_level_up.item_sendo_arrastado = self
	interface_de_level_up.mpos = get_local_mouse_position()
	interface_de_level_up.iniciar_arrastamento_de_item()
