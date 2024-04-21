@icon("res://Assets/Place Holder/Icones/4614123.png")
class_name SISTEMA_DE_LEVEL_UP
extends Control

@onready var mapa:TextureRect = $Organizador/BackgroundCantoEsquerdo/Marginalizador/Organizador/Mapa

@onready var imagem_pontos_disponiveis:TextureRect = $Organizador/BackgroundCentro/OrganizadorPrincpal/MaginalizadorSuperior/OrganizadorDeRecurssos/ImagemPontosDisponiveis
@onready var etiqueta_pontos_disponiveis:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/MaginalizadorSuperior/OrganizadorDeRecurssos/PontosDisponiveis

@onready var imagem_dinheiro_disponivel:TextureRect = $Organizador/BackgroundCentro/OrganizadorPrincpal/MaginalizadorSuperior/OrganizadorDeRecurssos/ImagemDinheiroDisponivel
@onready var etiqueta_dinheiro_disponivel:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/MaginalizadorSuperior/OrganizadorDeRecurssos/DinheiroDisponivel

@onready var imagem_altura_atual:TextureRect = $Organizador/BackgroundCentro/OrganizadorPrincpal/MaginalizadorSuperior/OrganizadorDeRecurssos/ImagemAlturaAtual
@onready var etiqueta_altura_atual:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/MaginalizadorSuperior/OrganizadorDeRecurssos/AlturaAtual

@onready var botao_negativo_vida:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorVida/BotaoNegativoVida
@onready var botao_positivo_vida:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorVida/BotaoPositivoVida
@onready var etiqueta_valor_atual_vida:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorVida/BackgroundValorAtualVida/ValorAtualVida
@onready var valor_final_vida:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorVida/BackgroundValorFinalVida/ValorFinalVida

@onready var botao_negativo_mana:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorMana/BotaoNegativoMana
@onready var botao_positivo_mana:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorMana/BotaoPositivoMana
@onready var etiqueta_valor_atual_mana:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorMana/BacgroundValorAtualMana/ValorAtualMana
@onready var valor_final_mana:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorMana/BacgroundValorFinalMana/ValorFinalMana

@onready var botao_negativo_estamina:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorEstamina/BotaoNegativoEstamina
@onready var botao_positivo_estamina:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorEstamina/BotaoPositivoEstamina
@onready var etiqueta_valor_atual_estamina:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorEstamina/BackgroundValorAtualEstamina/ValorAtualEstamina
@onready var valor_final_estamina:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorEstamina/BackgroundValorFinalEstamina/ValorFinalEstamina

@onready var botao_negativo_forca:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorForca/BotaoNegativoForca
@onready var botao_positivo_forca:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorForca/BotaoPositivoForca
@onready var etiqueta_valor_atual_forca:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorForca/BacgroundValorAtualForca/ValorAtualForca
@onready var valor_final_forca:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorForca/BackgroundValorFinalForca/ValorFinalForca

@onready var botao_negativo_destreza:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorDestreza/BotaoNegativoDestreza
@onready var botao_positivo_destreza:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorDestreza/BotaoPositivoDestreza
@onready var etiqueta_valor_atual_destreza:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorDestreza/BackgroundValorAtualDestreza/ValorAtualDestreza
@onready var valor_final_destreza:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorDestreza/BackgroundValorFinalDestreza/ValorFinalDestreza

@onready var botao_negativo_constituicao:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorConstituicao/BotaoNegativoConstituicao
@onready var botao_positivo_constituicao:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorConstituicao/BotaoPositivoConstituicao
@onready var etiqueta_valor_atual_constituicao:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorConstituicao/BackgroundValorAtualConstituicao/ValorAtualConstituicao
@onready var valor_final_constituicao:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/OrganizadorConstituicao/BackgroundValorFinalConstituicao/ValorFinalConstituicao

@onready var botao_confirmar_ou_sair:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/BackgroundBotoesFinais/OrganizadorBotoesFinais/CentralizadorDeBotoes/Botoes/BotaoConfirmarOuSair
@onready var confirmar_ou_sair:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/BackgroundBotoesFinais/OrganizadorBotoesFinais/CentralizadorDeBotoes/Botoes/BotaoConfirmarOuSair/ConfirmarOuSair

@onready var botao_aleatorizar_ou_desistir:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/BackgroundBotoesFinais/OrganizadorBotoesFinais/CentralizadorDeBotoes/Botoes/BotaoAleatorizarOuDesistir
@onready var aleatorizar_ou_desistir:Label = $Organizador/BackgroundCentro/OrganizadorPrincpal/BackgroundBotoesFinais/OrganizadorBotoesFinais/CentralizadorDeBotoes/Botoes/BotaoAleatorizarOuDesistir/AleatorizarOuDesistir

@onready var botao_melhorar_arma:TextureButton = $Organizador/BackgroundCentro/OrganizadorPrincpal/BackgroundBotoesFinais/OrganizadorBotoesFinais/CentralizadorDeBotoes/Botoes/BotaoMelhorarArma

@onready var armas_passivas_slot_1:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BacgroundSlotsArmasPassivas/OrganizadorArmasPassivas/SlotsArmasPassivas/ArmasPassivasSlot1
@onready var armas_passivas_slot_2:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BacgroundSlotsArmasPassivas/OrganizadorArmasPassivas/SlotsArmasPassivas/ArmasPassivasSlot2
@onready var armas_passivas_slot_3:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BacgroundSlotsArmasPassivas/OrganizadorArmasPassivas/SlotsArmasPassivas/ArmasPassivasSlot3
@onready var armas_passivas_slot_4:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BacgroundSlotsArmasPassivas/OrganizadorArmasPassivas/SlotsArmasPassivas/ArmasPassivasSlot4
@onready var armas_passivas_slot_5:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BacgroundSlotsArmasPassivas/OrganizadorArmasPassivas/SlotsArmasPassivas/ArmasPassivasSlot5
@onready var armas_passivas_slot_6:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BacgroundSlotsArmasPassivas/OrganizadorArmasPassivas/SlotsArmasPassivas/ArmasPassivasSlot6

@onready var armas_ativas_slot_1:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsArmasAtivas/OrganizadorArmasAtivas/SlotsArmasAtivas/ArmasAtivasSlot1
@onready var armas_ativas_slot_2:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsArmasAtivas/OrganizadorArmasAtivas/SlotsArmasAtivas/ArmasAtivasSlot2
@onready var armas_ativas_slot_3:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsArmasAtivas/OrganizadorArmasAtivas/SlotsArmasAtivas/ArmasAtivasSlot3
@onready var armas_ativas_slot_4:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsArmasAtivas/OrganizadorArmasAtivas/SlotsArmasAtivas/ArmasAtivasSlot4
@onready var armas_ativas_slot_5:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsArmasAtivas/OrganizadorArmasAtivas/SlotsArmasAtivas/ArmasAtivasSlot5
@onready var armas_ativas_slot_6:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsArmasAtivas/OrganizadorArmasAtivas/SlotsArmasAtivas/ArmasAtivasSlot6

@onready var habilidades_slot_1:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsHabilidades/OrganizadorHabilidades/SlotsHabilidades/HabilidadesSlot1
@onready var habilidades_slot_2:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsHabilidades/OrganizadorHabilidades/SlotsHabilidades/HabilidadesSlot2
@onready var habilidades_slot_3:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsHabilidades/OrganizadorHabilidades/SlotsHabilidades/HabilidadesSlot3
@onready var habilidades_slot_4:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsHabilidades/OrganizadorHabilidades/SlotsHabilidades/HabilidadesSlot4
@onready var habilidades_slot_5:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsHabilidades/OrganizadorHabilidades/SlotsHabilidades/HabilidadesSlot5
@onready var habilidades_slot_6:TextureRect = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsHabilidades/OrganizadorHabilidades/SlotsHabilidades/HabilidadesSlot6

@onready var texto_informacoes:RichTextLabel = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundInformacoes/OrganizadorInformacoes/Centralizador/AtivadorDeScroll/OrganizadorDeLista/TextoInformacoes
@onready var segurador_temporario:Node = $SeguradorTemporario
@onready var slots_armas_passivas:GridContainer = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BacgroundSlotsArmasPassivas/OrganizadorArmasPassivas/SlotsArmasPassivas
@onready var slots_armas_ativas:GridContainer = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsArmasAtivas/OrganizadorArmasAtivas/SlotsArmasAtivas
@onready var slots_habilidades:GridContainer = $Organizador/BacgroundCantoDireito/Marginalizador/OrganizadorItensEInformacoes/BackgroundSlotsHabilidades/OrganizadorHabilidades/SlotsHabilidades

var personagem:PERSONAGEM_BASE

var nivel:int
var pontos_disponiveis:int = 0
var dinheiro_atual:int = 0:
	set(valor):
		dinheiro_atual = valor
		etiqueta_dinheiro_disponivel.set_text(str(dinheiro_atual))

var valor_altura_atual:float = 0
var valor_altura_anterior:float = 0
var pontos_de_altura_adquiridos:float
var subiu:bool = false

var presentes_adquiridos:float = 1

var vida_atual:float
var vida_final:float

var mana_atual:float
var mana_final:float

var estamina_atual:float
var estamina_final:float

var forca_atual:float
var forca_final:float

var constituicao_atual:float
var constituicao_final:float

var destreza_atual:float
var destreza_final:float

var lista_de_mostruarios:Array = []
var lista_de_armas_ativas:Dictionary = {
	"0": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"1": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"2": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"3": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"4": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"5": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
}
var lista_de_armas_passivas:Dictionary = {
	"0": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"1": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"2": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"3": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"4": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"5": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
}
var lista_de_habilidades:Dictionary = {
	"0": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"1": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"2": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"3": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"4": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
	"5": {
		"Index": null,
		"Nodo": null,
		"Nivel": null,
		"Nome": null,
		"Descricao": null
	},
}

var lista_de_combinacoes_de_armas_possiveis:Array = []
#var mapa:MINI_MAPA

var subiu_de_nivel:bool = false
var arrastando_item:bool = false
var item_sendo_arrastado:MOSTRUARIO_DE_ARMAS
var mpos:Vector2

func _ready():
	personagem = find_parent("Nova_Cena_Teste").find_child("Personagem").get_child(0)
	atualizar_valores_basicos()

func atualizar_informacoes() -> void:
	etiqueta_pontos_disponiveis.set_text(str(pontos_disponiveis))
	etiqueta_altura_atual.set_text(str(pontos_de_altura_adquiridos))
	etiqueta_dinheiro_disponivel.set_text(str(dinheiro_atual))
	etiqueta_valor_atual_constituicao.set_text(str(constituicao_atual))
	etiqueta_valor_atual_destreza.set_text(str(destreza_atual))
	etiqueta_valor_atual_estamina.set_text(str(estamina_atual))
	etiqueta_valor_atual_forca.set_text(str(forca_atual))
	etiqueta_valor_atual_mana.set_text(str(mana_atual))
	etiqueta_valor_atual_vida.set_text(str(vida_atual))
	valor_final_constituicao.set_text(str(constituicao_final))
	valor_final_destreza.set_text(str(destreza_final))
	valor_final_estamina.set_text(str(estamina_final))
	valor_final_forca.set_text(str(forca_final))
	valor_final_mana.set_text(str(mana_final))
	valor_final_vida.set_text(str(vida_final))

func atualizar_informacoes_finais() -> void:
	vida_final = vida_atual
	mana_final = mana_atual
	estamina_final = estamina_atual
	forca_final = forca_atual
	destreza_final = destreza_atual
	constituicao_final = constituicao_atual

func atualizar_valores_basicos() -> void:
	nivel = personagem.valores_do_jogador.nivel
	vida_atual = personagem.barra_de_vida.vida_maxima
	mana_atual = personagem.barra_de_mana.mana_maxima
	estamina_atual = personagem.barra_de_estamina.estamina_maxima
	forca_atual = personagem.valores_do_jogador.forca
	destreza_atual = personagem.valores_do_jogador.destreza
	constituicao_atual = personagem.valores_do_jogador.constituicao
	
	var armas_ativas_temp:Array = personagem.armas_ativas.get_children()
	if !armas_ativas_temp.is_empty():
		var count:int = 0
		for arma in armas_ativas_temp:
			lista_de_armas_ativas[str(count)]["Index"] = arma.index
			lista_de_armas_ativas[str(count)]["Nodo"] = arma
			lista_de_armas_ativas[str(count)]["Nome"] = arma.nome
			lista_de_armas_ativas[str(count)]["Nivel"] = arma.nivel
			lista_de_armas_ativas[str(count)]["Descricao"] = arma.descricao
			count += 1
	
	var armas_passivas_temp:Array = personagem.armas_passivas.get_children()
	if !armas_passivas_temp.is_empty():
		var count:int = 0
		for arma in armas_passivas_temp:
			lista_de_armas_passivas[str(count)]["Index"] = arma.index
			lista_de_armas_passivas[str(count)]["Nodo"] = arma
			lista_de_armas_passivas[str(count)]["Nome"] = arma.nome
			lista_de_armas_passivas[str(count)]["Nivel"] = arma.nivel
			lista_de_armas_passivas[str(count)]["Descricao"] = arma.descricao
			count += 1
	
	#var habilidades_temp:Array = personagem.habilidades.get_children()
	#if !habilidades_temp.is_empty():
		#var count:int = 0
		#for habilidade in habilidades_temp:
			#lista_de_habilidades[str(count)]["Index"] = habilidade.index
			#lista_de_habilidades[str(count)]["Nodo"] = habilidade
			#lista_de_habilidades[str(count)]["Nome"] = habilidade.nome
			#lista_de_habilidades[str(count)]["Nivel"] = habilidade.nivel
			#lista_de_habilidades[str(count)]["Descricao"] = habilidade.descricao
			#count += 1
	
	implementar_mostruario_de_arma()
	lista_de_combinacoes_de_armas_possiveis = verificar_combinacoes_possiveis()

func liberar_ou_travar_botoes_de_alteracao_de_atributos() -> void:
	if subiu_de_nivel == false:
		var lista_de_botoes_positivos:Array = get_tree().get_nodes_in_group("BotoesPositivos")
		var lista_de_botoes_negativos:Array = get_tree().get_nodes_in_group("BotoesNegativos")
		for botao:TextureButton in lista_de_botoes_positivos:
			botao.disabled = true
		for botao:TextureButton in lista_de_botoes_negativos:
			botao.disabled = true
	else:
		var lista_de_valores_atuais:Array = [vida_atual,mana_atual,estamina_atual,forca_atual,destreza_atual,constituicao_atual]
		var lista_de_valores_finais:Array = [vida_final,mana_final,estamina_final,forca_final,destreza_final,constituicao_final]
		var lista_de_botoes_positivos:Array = get_tree().get_nodes_in_group("BotoesPositivos")
		var lista_de_botoes_negativos:Array = get_tree().get_nodes_in_group("BotoesNegativos")
		var count:int = 0
		for valor:float in lista_de_valores_atuais:
			for botao:TextureButton in lista_de_botoes_positivos:
				if valor == lista_de_valores_finais[count] && pontos_disponiveis > 0:
					botao.disabled = false
				elif valor == lista_de_valores_finais[count] && pontos_disponiveis == 0:
					botao.disabled = true
				elif valor < lista_de_valores_finais[count] && pontos_disponiveis > 0:
					botao.disabled = false
				elif valor < lista_de_valores_finais[count] && pontos_disponiveis == 0:
					botao.disabled = true
			for botao:TextureButton in lista_de_botoes_negativos:
				if valor == lista_de_valores_finais[count] && pontos_disponiveis > 0:
					botao.disabled = true
				elif valor == lista_de_valores_finais[count] && pontos_disponiveis == 0:
					botao.disabled = true
				elif valor < lista_de_valores_finais[count] && pontos_disponiveis > 0:
					botao.disabled = false
				elif valor < lista_de_valores_finais[count] && pontos_disponiveis == 0:
					botao.disabled = false
			count += 1

func verificar_combinacoes_possiveis() -> Array:
	var array:Array = []
	return array

func desativar_interface() -> void:
	if self.is_visible_in_tree():
		self.hide()
		find_parent("Nova_Cena_Teste").camera.get_child(0).enabled = true

func _process(_delta):
	if subiu_de_nivel == false && Input.is_action_just_pressed("ESC"):
		desativar_interface()
	await get_tree().create_timer(0.01).timeout
	if !self.is_visible_in_tree():
		get_tree().paused = false
	
	atualizar_informacoes()
	modificador_de_funcionalidade_dos_botoes()
	chamador_inicial_de_ativador()

func _physics_process(_delta):
	if arrastando_item == true:
		arrastar_itens()

func modificador_de_funcionalidade_dos_botoes():
	if subiu_de_nivel == true:
		if pontos_disponiveis > 0:
			botao_confirmar_ou_sair.disabled = true
			botao_aleatorizar_ou_desistir.disabled = false
		else:
			botao_confirmar_ou_sair.disabled = false
			botao_aleatorizar_ou_desistir.disabled = true
		confirmar_ou_sair.set_text("Confirmar")
		aleatorizar_ou_desistir.set_text("Aleaotrizar")
		if pontos_disponiveis >= 5:
			botao_melhorar_arma.disabled = false
		else:
			botao_melhorar_arma.disabled = true
	else:
		botao_confirmar_ou_sair.disabled = false
		botao_aleatorizar_ou_desistir.disabled = false
		confirmar_ou_sair.set_text("Sair")
		aleatorizar_ou_desistir.set_text("Desistir")
		botao_melhorar_arma.disabled = true

func _on_botao_confirmar_ou_sair_pressed():
	if subiu_de_nivel == false:
		desativar_interface()
	else:
		aplicar_modificacoes()

func _on_botao_aleatorizar_ou_desistir_pressed():
	if subiu_de_nivel == false:
		get_tree().quit()
	else:
		aleatorizar_melhoria()

func _on_botao_melhorar_arma_pressed():
	if pontos_disponiveis >= 5:
		pontos_disponiveis -= 5
		melhorar_arma(true)

func aplicar_modificacoes() -> void:
	personagem.barra_de_vida.vida_maxima = vida_final
	vida_atual = vida_final
	personagem.barra_de_mana.mana_maxima = mana_final
	mana_atual = mana_final
	personagem.barra_de_estamina.estamina_maxima = estamina_final
	estamina_atual = estamina_final
	personagem.valores_do_jogador.forca = forca_final
	forca_atual = forca_final
	personagem.valores_do_jogador.destreza = destreza_final
	destreza_atual = destreza_final
	personagem.valores_do_jogador.constituicao = constituicao_final
	constituicao_atual = constituicao_final
	desativar_interface()

func aleatorizar_melhoria(valor_investido:float = 1) -> void:
	var sortear_atributo:int = randi_range(0,100)
	if sortear_atributo <= 14:
		vida_final += valor_investido
	elif sortear_atributo <= 28:
		mana_final += valor_investido
	elif sortear_atributo <= 42:
		estamina_final += valor_investido
	elif sortear_atributo <= 56:
		forca_final += valor_investido / 10
	elif sortear_atributo <= 70:
		constituicao_final += valor_investido / 10
	elif sortear_atributo <= 84:
		destreza_final += valor_investido / 10
	elif sortear_atributo <= 98:
		if valor_investido > 1:
			aleatorizar_melhoria(valor_investido)
		else:
			melhorar_arma()
	elif sortear_atributo <= 100:
		vida_final += valor_investido
		mana_final += valor_investido
		estamina_final += valor_investido
		forca_final += valor_investido / 10
		constituicao_final += valor_investido / 10
		destreza_final += valor_investido / 10
		if valor_investido > 1:
			personagem.sistema_de_dano.calculadora_de_dano_de_vida(true,"Radiante",9999,9999)
			personagem.sistema_de_dano.calculadora_de_dano_de_mana(true,9999,1)
			personagem.sistema_de_dano.calculadora_de_dano_de_estamina(true,9999,9999,1)
		else:
			melhorar_arma()
	aplicar_modificacoes()

func melhorar_arma(verificador:bool = false) -> void:
	for slot in lista_de_armas_ativas:
		if lista_de_armas_ativas[slot]["Nodo"] != null:
			if lista_de_armas_ativas[slot]["Nivel"] < 10:
				var novo_nodo:Node2D = instanciar_nova_arma(lista_de_armas_ativas[slot]["Nodo"])
				lista_de_armas_ativas[slot]["Index"] = novo_nodo.index 
				lista_de_armas_ativas[slot]["Nodo"] = novo_nodo
				lista_de_armas_ativas[slot]["Nome"] = novo_nodo.name
				lista_de_armas_ativas[slot]["Nivel"] = novo_nodo.nivel
				lista_de_armas_ativas[slot]["Descricao"] = novo_nodo.descricao
				if !lista_de_mostruarios.is_empty():
					for mostruario in lista_de_mostruarios:
						mostruario._ready()
				return
	for slot in lista_de_armas_passivas:
		if lista_de_armas_passivas[slot]["Nodo"] != null:
			if lista_de_armas_passivas[slot]["Nivel"] < 10:
				var novo_nodo:Node2D = instanciar_nova_arma(lista_de_armas_ativas[slot]["Nodo"])
				lista_de_armas_passivas[slot]["Index"] = novo_nodo.index 
				lista_de_armas_passivas[slot]["Nodo"] = novo_nodo
				lista_de_armas_passivas[slot]["Nome"] = novo_nodo.name
				lista_de_armas_passivas[slot]["Nivel"] = novo_nodo.nivel
				lista_de_armas_passivas[slot]["Descricao"] = novo_nodo.descricao
				if !lista_de_mostruarios.is_empty():
					for mostruario in lista_de_mostruarios:
						mostruario._ready()
				return
	
	if verificador == true:
		aleatorizar_melhoria(5)
	else:
		aleatorizar_melhoria()
	
	

func instanciar_nova_arma(Nodo_antigo:Node2D) -> Node2D:
	var novo_index:int = Nodo_antigo.index + 1
	var info:Dictionary = Nodo_antigo.concatenacao[str(novo_index)]
	Nodo_antigo.modificar_valores_principais(info)
	return Nodo_antigo

func chamador_inicial_de_ativador() -> void:
	if subiu_de_nivel == false:
		var lista_de_botoes_positivo:Array = get_tree().get_nodes_in_group("BotoesPositivos")
		var lista_de_botoes_negativo:Array = get_tree().get_nodes_in_group("BotoesNegativos")
		for botao:TextureButton in lista_de_botoes_positivo:
			botao.disabled = true
		for botao:TextureButton in lista_de_botoes_negativo:
			botao.disabled = true
	else:
		var lista_de_botoes_positivo:Array = get_tree().get_nodes_in_group("BotoesPositivos")
		var lista_de_botoes_negativo:Array = get_tree().get_nodes_in_group("BotoesNegativos")
		var lista_de_categorias_atuais:Array = [vida_atual,mana_atual,estamina_atual,forca_atual,destreza_atual,constituicao_atual]
		var lista_de_categorias_finais:Array = [vida_final,mana_final,estamina_final,forca_final,destreza_final,constituicao_final]
		var count:int = 0
		for botao:TextureButton in lista_de_botoes_positivo:
			ativador_desativador_de_botao(botao,true,lista_de_categorias_atuais[count],lista_de_categorias_finais[count],pontos_disponiveis)
			count += 1
		count = 0
		for botao:TextureButton in lista_de_botoes_negativo:
			ativador_desativador_de_botao(botao,false,lista_de_categorias_atuais[count],lista_de_categorias_finais[count],pontos_disponiveis)
			count += 1

func ativador_desativador_de_botao(botao:TextureButton, positivo:bool, categoria_atual:float,categoria_final:float, pontos_atuais:float) -> void:
	if positivo == true:
		if categoria_atual == categoria_final && pontos_atuais > 0:
			botao.disabled = false
		if categoria_atual == categoria_final && pontos_atuais == 0:
			botao.disabled = true
		if categoria_atual < categoria_final && pontos_atuais > 0:
			botao.disabled = false
		if categoria_atual < categoria_final && pontos_atuais == 0:
			botao.disabled = true
	else:
		if categoria_atual == categoria_final && pontos_atuais > 0:
			botao.disabled = true
		if categoria_atual == categoria_final && pontos_atuais == 0:
			botao.disabled = true
		if categoria_atual < categoria_final && pontos_atuais > 0:
			botao.disabled = false
		if categoria_atual < categoria_final && pontos_atuais == 0:
			botao.disabled = false

func _on_botao_negativo_vida_pressed():
	pontos_disponiveis += 1
	vida_final -= 10

func _on_botao_positivo_vida_pressed():
	pontos_disponiveis -= 1
	vida_final += 10

func _on_botao_negativo_mana_pressed():
	pontos_disponiveis += 1
	mana_final -= 5

func _on_botao_positivo_mana_pressed():
	pontos_disponiveis -= 1
	mana_final += 5

func _on_botao_negativo_estamina_pressed():
	pontos_disponiveis += 1
	estamina_final -= 10

func _on_botao_positivo_estamina_pressed():
	pontos_disponiveis -= 1
	estamina_final += 10

func _on_botao_negativo_forca_pressed():
	pontos_disponiveis += 1
	forca_final -= 0.5

func _on_botao_positivo_forca_pressed():
	pontos_disponiveis -= 1
	forca_final += 0.5

func _on_botao_negativo_destreza_pressed():
	pontos_disponiveis += 1
	destreza_final -= 0.5

func _on_botao_positivo_destreza_pressed():
	pontos_disponiveis -= 1
	destreza_final += 0.5

func _on_botao_negativo_constituicao_pressed():
	pontos_disponiveis += 1
	constituicao_final -= 0.5

func _on_botao_positivo_constituicao_pressed():
	pontos_disponiveis -= 1
	constituicao_final += 0.5

func calcular_pontos_de_altura() -> void:
	if valor_altura_atual < valor_altura_anterior:
		if valor_altura_anterior - valor_altura_atual > 50:
			pontos_de_altura_adquiridos += round((valor_altura_anterior - valor_altura_atual) / 100)
			atualizar_informativo_de_altura()

func atualizar_informativo_de_altura() -> void:
	etiqueta_altura_atual.set_text(str(pontos_de_altura_adquiridos))

func implementar_mostruario_de_arma() -> void:
	if lista_de_armas_passivas[str(0)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Passiva"
		mostruario_armas_instancia.slot_atual = 0
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_armas_passivas[str(1)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Passiva"
		mostruario_armas_instancia.slot_atual = 1
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_armas_passivas[str(2)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Passiva"
		mostruario_armas_instancia.slot_atual = 2
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_armas_passivas[str(3)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Passiva"
		mostruario_armas_instancia.slot_atual = 3
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_armas_passivas[str(4)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Passiva"
		mostruario_armas_instancia.slot_atual = 4
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_armas_passivas[str(5)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Passiva"
		mostruario_armas_instancia.slot_atual = 5
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	
	if lista_de_armas_ativas[str(0)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Ativas"
		mostruario_armas_instancia.slot_atual = 0
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_armas_ativas[str(1)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Ativas"
		mostruario_armas_instancia.slot_atual = 1
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_armas_ativas[str(2)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Ativas"
		mostruario_armas_instancia.slot_atual = 2
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_armas_ativas[str(3)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Ativas"
		mostruario_armas_instancia.slot_atual = 3
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_armas_ativas[str(4)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Ativas"
		mostruario_armas_instancia.slot_atual = 4
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_armas_ativas[str(5)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Ativas"
		mostruario_armas_instancia.slot_atual = 5
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	
	if lista_de_habilidades[str(0)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Habilidades"
		mostruario_armas_instancia.slot_atual = 0
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_habilidades[str(1)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Habilidades"
		mostruario_armas_instancia.slot_atual = 1
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_habilidades[str(2)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Habilidades"
		mostruario_armas_instancia.slot_atual = 2
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_habilidades[str(3)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Habilidades"
		mostruario_armas_instancia.slot_atual = 3
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_habilidades[str(4)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Habilidades"
		mostruario_armas_instancia.slot_atual = 4
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	elif lista_de_habilidades[str(5)]["Index"] != null:
		var mostruario_armas_instancia:MOSTRUARIO_DE_ARMAS = DATA.CON.Mostruario_de_armas.instantiate()
		mostruario_armas_instancia.tipo_de_slot = "Habilidades"
		mostruario_armas_instancia.slot_atual = 5
		mostruario_armas_instancia.interface_de_level_up = self
		armas_passivas_slot_1.add_child(mostruario_armas_instancia)
		lista_de_mostruarios += [mostruario_armas_instancia]
	
	for mostruario in lista_de_mostruarios:
		item_sendo_arrastado = mostruario
		corrigir_posicao()

func arrastar_itens() -> void:
	item_sendo_arrastado.global_position = get_global_mouse_position() - mpos

func iniciar_arrastamento_de_item() -> void:
	item_sendo_arrastado.reparent(segurador_temporario)

func verificar_posicao_valida() -> Dictionary:
	var info:Dictionary = {"Posicao_valida":false, "Slot":item_sendo_arrastado.tipo_de_slot}
	if item_sendo_arrastado.global_position.x >= slots_armas_ativas.global_position.x && item_sendo_arrastado.global_position.x <= slots_armas_ativas.global_position.x + slots_armas_ativas.size.x:
		if item_sendo_arrastado.global_position.y >= slots_armas_ativas.global_position.y && item_sendo_arrastado.global_position.y <= slots_armas_ativas.global_position.y + slots_armas_ativas.size.y:
			info["Posicao_valida"] = true
			info["Slot"] = "Ativas"
			return info
	if item_sendo_arrastado.global_position.x >= slots_armas_passivas.global_position.x && item_sendo_arrastado.global_position.x <= slots_armas_passivas.global_position.x + slots_armas_passivas.size.x:
		if item_sendo_arrastado.global_position.y >= slots_armas_passivas.global_position.y && item_sendo_arrastado.global_position.y <= slots_armas_passivas.global_position.y + slots_armas_passivas.size.y:
			info["Posicao_valida"] = true
			info["Slot"] = "Passivas"
			return info
	
	if item_sendo_arrastado.global_position.x >= slots_habilidades.global_position.x && item_sendo_arrastado.global_position.x <= slots_habilidades.global_position.x + slots_habilidades.size.x:
		if item_sendo_arrastado.global_position.y >= slots_habilidades.global_position.y && item_sendo_arrastado.global_position.y <= slots_habilidades.global_position.y + slots_habilidades.size.y:
			info["Posicao_valida"] = true
			info["Slot"] = "Habilidades"
			return info
			
	return info

func corrigir_posicao() -> void:
	var posicao_valida = verificar_posicao_valida()
	if posicao_valida["Posicao_valida"] == true:
		if posicao_valida["Slot"] == "Ativas":
			for slots in slots_armas_ativas.get_children():
				if slots.get_child_count() == 0:
					item_sendo_arrastado.global_position = slots.global_position
					item_sendo_arrastado.reparent(slots)
					alterar_funcionalidade_da_arma()
					return
		elif posicao_valida["Slot"] == "Passivas":
			for slots in slots_armas_passivas.get_children():
				if slots.get_child_count() == 0:
					item_sendo_arrastado.global_position = slots.global_position
					item_sendo_arrastado.reparent(slots)
					alterar_funcionalidade_da_arma()
					return
		elif posicao_valida["Slot"] == "Habilidades":
			for slots in slots_habilidades.get_children():
				if slots.get_child_count() == 0:
					item_sendo_arrastado.global_position = slots.global_position
					item_sendo_arrastado.reparent(slots)
					alterar_funcionalidade_da_arma()
					return
	else: 
		if posicao_valida["Slot"] == "Ativas":
			for slots in slots_armas_ativas.get_children():
				if slots.get_child_count() == 0:
					item_sendo_arrastado.global_position = slots.global_position
					item_sendo_arrastado.reparent(slots)
					alterar_funcionalidade_da_arma()
					return
		elif posicao_valida["Slot"] == "Passivas":
			for slots in slots_armas_passivas.get_children():
				if slots.get_child_count() == 0:
					item_sendo_arrastado.global_position = slots.global_position
					item_sendo_arrastado.reparent(slots)
					alterar_funcionalidade_da_arma()
					return
		elif posicao_valida["Slot"] == "Habilidades":
			for slots in slots_habilidades.get_children():
				if slots.get_child_count() == 0:
					item_sendo_arrastado.global_position = slots.global_position
					item_sendo_arrastado.reparent(slots)
					alterar_funcionalidade_da_arma()
					return
	

func alterar_funcionalidade_da_arma() -> void:
	var pai = item_sendo_arrastado.get_parent().get_parent().name
	if pai == "SlotsArmasAtivas":
		if item_sendo_arrastado is MOSTRUARIO_DE_ARMAS:
			if item_sendo_arrastado.tipo_de_slot == "Passiva":
				var arma = lista_de_armas_passivas[str(item_sendo_arrastado.slot_atual)]["Nodo"]
				arma.ativa = true
				arma.temporizador_de_balas_por_segundo.start()
			else:
				var arma = lista_de_armas_ativas[str(item_sendo_arrastado.slot_atual)]["Nodo"]
				arma.ativa = true
				arma.temporizador_de_balas_por_segundo.start()
	elif pai == "SlotsArmasPassivas":
		if item_sendo_arrastado is MOSTRUARIO_DE_ARMAS:
			if item_sendo_arrastado.tipo_de_slot == "Passiva":
				var arma = lista_de_armas_passivas[str(item_sendo_arrastado.slot_atual)]["Nodo"]
				arma.ativa = false
				arma.temporizador_de_balas_por_segundo.start()
			else:
				var arma = lista_de_armas_ativas[str(item_sendo_arrastado.slot_atual)]["Nodo"]
				arma.ativa = false
				arma.temporizador_de_balas_por_segundo.start()
	else:
		push_error("slot de habilidade não é valido pra arma")
	
