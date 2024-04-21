class_name PERSONAGEM_BASE
extends CharacterBody2D

@onready var organizador_de_mecanicas:Node = $"Organizador de Mecanicas"
@onready var organizador_de_informativos:VBoxContainer = $"Organizador de Informativos"
@onready var area_de_colisao:CollisionShape2D = $AreaDeColisao
@onready var detector_de_chao_direita:RayCast2D = $"Organizador de Detector/DetectorDeChaoDireita"
@onready var detector_de_chao_esquerda:RayCast2D = $"Organizador de Detector/DetectorDeChaoEsquerda"
@onready var detecetor_de_parede_esquerda_1:RayCast2D = $"Organizador de Detector/DetecetorDeParedeEsquerda1"
@onready var detecetor_de_parede_esquerda_2:RayCast2D = $"Organizador de Detector/DetecetorDeParedeEsquerda2"
@onready var detecetor_de_parede_esquerda_3:RayCast2D = $"Organizador de Detector/DetecetorDeParedeEsquerda3"
@onready var detecetor_de_parede_direita_1:RayCast2D = $"Organizador de Detector/DetecetorDeParedeDireita1"
@onready var detecetor_de_parede_direita_2:RayCast2D = $"Organizador de Detector/DetecetorDeParedeDireita2"
@onready var detecetor_de_parede_direita_3:RayCast2D = $"Organizador de Detector/DetecetorDeParedeDireita3"
@onready var armas_ativas:Marker2D = $"Organizador de itens/Armas/Ativas"
@onready var armas_passivas:Marker2D = $"Organizador de itens/Armas/Passivas"
@onready var hurtbox:Area2D = $Hurtbox
@onready var colisao_da_hurtbox:CollisionShape2D = $Hurtbox/ColisaoDaHurtbox
@onready var organizador_de_audios:Node = $"Organizador de Audios"
@onready var zona_de_coleta = $ZonaDeColeta
@onready var delimitador_de_zona_de_coleta = $ZonaDeColeta/DelimitadorDeZonaDeColeta

var idx:int
var valores_do_jogador:VALORES_DO_JOGADOR
var regulador_do_jogador:REGULADOR_DOS_JOGADORES
var sistema_de_dano:SISTEMA_DE_DANO

var barra_de_vida:BARRA_DE_VIDA
var barra_de_mana:BARRA_DE_MANA
var barra_de_estamina:BARRA_DE_ESTAMINA
var barra_de_experiencia:BARRA_DE_EXPERIENCIA

var maquina_de_estados:MAQUINA_DE_ESTADO
var pulos_atuais:int = 0

var morto:bool = false

func _ready() -> void:
	carregar_informacoes_de_personagem(idx)

func carregar_informacoes_de_personagem(index:int) -> void:
	instanciar_mecanicas()
	valores_do_jogador.nivel = 1
	valores_do_jogador.vida_incial = DATA.DAT.DTB_PERS[str(index)]["Vida"]
	valores_do_jogador.mana_incial = DATA.DAT.DTB_PERS[str(index)]["Mana"]
	valores_do_jogador.estamina_incial = DATA.DAT.DTB_PERS[str(index)]["Estamina"]
	valores_do_jogador.lista_de_estados = DATA.DAT.DTB_PERS[str(index)]["Lista_De_Estados_Movimento"] + DATA.DAT.DTB_PERS[str(index)]["Lista_De_Estados_Combate"] + DATA.DAT.DTB_PERS[str(index)]["Lista_De_Estados_Especial"]
	valores_do_jogador.forca = DATA.DAT.DTB_PERS[str(index)]["Forca"]
	valores_do_jogador.destreza = DATA.DAT.DTB_PERS[str(index)]["Destreza"]
	valores_do_jogador.constituicao = DATA.DAT.DTB_PERS[str(index)]["Constituicao"]
	valores_do_jogador.quantidade_de_pulos = DATA.DAT.DTB_PERS[str(index)]["Pulos"]
	delimitador_de_zona_de_coleta.shape.radius = DATA.DAT.DTB_PERS[str(index)]["area_de_coleta"]
	self.set_name("personagem_" + DATA.DAT.DTB_PERS[str(index)]["Nome"])
	instanciar_informativos()
	instanciar_estados(index)
	if DATA.DAT.DTB_PERS[str(index)]["Tipo_arma_inicial"] == "Longa_distancia":
		instanciar_armas_de_longa_distancia(DATA.DAT.DTB_PERS[str(index)]["Index_arma_inicial"])
	elif DATA.DAT.DTB_PERS[str(index)]["Tipo_arma_inicial"] == "Ataque_em_area":
		instancia_armas_de_ataque_em_area(DATA.DAT.DTB_PERS[str(index)]["Index_arma_inicial"])
	elif DATA.DAT.DTB_PERS[str(index)]["Tipo_arma_inicial"] == "Projetil":
		instanciar_armas_de_longa_distancia(DATA.DAT.DTB_PERS[str(index)]["Index_arma_inicial"])
	elif DATA.DAT.DTB_PERS[str(index)]["Tipo_arma_inicial"] == "Pontual":
		instancia_armas_de_ataque_em_area(DATA.DAT.DTB_PERS[str(index)]["Index_arma_inicial"])


func instanciar_informativos() -> void:
	if valores_do_jogador.vida_incial != null:
		var barra_instancia = DATA.CON.Barra_de_vida.instantiate()
		organizador_de_informativos.add_child(barra_instancia)
		organizador_de_informativos.barra_vida = barra_instancia
		barra_de_vida = barra_instancia
	if valores_do_jogador.mana_incial != null:
		var barra_instancia = DATA.CON.Barra_de_mana.instantiate()
		organizador_de_informativos.add_child(barra_instancia)
		organizador_de_informativos.barra_mana = barra_instancia
		barra_de_mana = barra_instancia
	if valores_do_jogador.estamina_incial != null:
		var barra_instancia = DATA.CON.Barra_de_estamina.instantiate()
		organizador_de_informativos.add_child(barra_instancia)
		organizador_de_informativos.barra_estamina = barra_instancia
		barra_de_estamina = barra_instancia
	if barra_de_experiencia == null:
		var barra_instancia = DATA.CON.Barra_De_Experiencia.instantiate()
		barra_instancia.personagem = self
		organizador_de_informativos.add_child(barra_instancia)
		organizador_de_informativos.barra_de_experiencia = barra_instancia
		barra_de_experiencia = barra_instancia

func instanciar_mecanicas() -> void:
	if organizador_de_mecanicas.get_child_count() == 0:
		var valor_instancia = DATA.CON.Valores_do_jogador.instantiate()
		organizador_de_mecanicas.add_child(valor_instancia)
		valores_do_jogador = valor_instancia
		valor_instancia.personagem = self
		var regulador_instancia = DATA.CON.Regulador_do_jogador.instantiate()
		organizador_de_mecanicas.add_child(regulador_instancia)
		regulador_do_jogador = regulador_instancia
		regulador_instancia.personagem = self
		var sistema_de_dano_instancia = DATA.CON.Sistema_de_dano.instantiate()
		organizador_de_mecanicas.add_child(sistema_de_dano_instancia)
		sistema_de_dano = sistema_de_dano_instancia
		sistema_de_dano.Receptor = self

func instanciar_estados(index:int) -> void:
	if !has_node("MaquinaDeEstado"):
		var maquina_instancia = DATA.CON.Maquina_de_estado.instantiate()
		maquina_de_estados = maquina_instancia
		maquina_instancia.personagem = self
		maquina_instancia.animacao = $SpriteAnimada
		add_child(maquina_instancia)
		for nomes in DATA.DAT.DTB_PERS[str(index)]["Lista_De_Estados_Movimento"]:
			var estado_instancia = DATA.CON.get(nomes).instantiate()
			maquina_instancia.get_child(0).add_child(estado_instancia)
		for nomes in DATA.DAT.DTB_PERS[str(index)]["Lista_De_Estados_Combate"]:
			var estado_instancia = DATA.CON.get(nomes).instantiate()
			maquina_instancia.get_child(1).add_child(estado_instancia)
		for nomes in DATA.DAT.DTB_PERS[str(index)]["Lista_De_Estados_Especial"]:
			var estado_instancia = DATA.CON.get(nomes).instantiate()
			maquina_instancia.get_child(2).add_child(estado_instancia)
		maquina_instancia.verificar_e_inicializar_maquina_de_estado()

func instanciar_armas_de_longa_distancia(index:int) -> void:
	var arma_instancia:ARMA_BASICA_DE_LONGA_DISTANCIA = DATA.CON.get(DATA.DAT.DTB_ARM_L_DIS[str(index)]["Nome"]).instantiate()
	arma_instancia.scale = Vector2(0.5,0.5)
	arma_instancia.position = armas_ativas.position
	arma_instancia.personagem = self
	arma_instancia.index = index
	arma_instancia.nome = DATA.DAT.DTB_ARM_L_DIS[str(index)]["Nome"]
	arma_instancia.nivel = DATA.DAT.DTB_ARM_L_DIS[str(index)]["Nivel"]
	arma_instancia.descricao = DATA.DAT.DTB_ARM_L_DIS[str(index)]["Descricao"]
	if DATA.DAT.DTB_ARM_L_DIS[str(index)]["Ativa"] == true:
		arma_instancia.ativa = true
		armas_ativas.add_child(arma_instancia)
	else:
		arma_instancia.ativa = false
		armas_passivas.add_child(arma_instancia)

func instancia_armas_de_ataque_em_area(index:int) -> void:
	var arma_instancia:ARMA_BASICA_DE_ATAQUE_EM_AREA = DATA.CON.get(DATA.DAT.DTB_ARM_ADE[str(index)]["Nome"]).instantiate()
	arma_instancia.scale = Vector2(0.5,0.5)
	arma_instancia.position = armas_ativas.position
	arma_instancia.index = index
	arma_instancia.nome = DATA.DAT.DTB_ARM_ADE[str(index)]["Nome"]
	arma_instancia.nivel = DATA.DAT.DTB_ARM_ADE[str(index)]["Nivel"]
	arma_instancia.alcance_maximo = DATA.DAT.DTB_ARM_ADE[str(index)]["alcance_maximo"]
	arma_instancia.descricao = DATA.DAT.DTB_ARM_ADE[str(index)]["descricao"]
	arma_instancia.personagem = self
	if DATA.DAT.DTB_ARM_ADE[str(index)]["Ativo"] == true:
		arma_instancia.ativa = true
		armas_ativas.add_child(arma_instancia)
	else:
		arma_instancia.ativa = false
		armas_ativas.add_child(arma_instancia)
	
func _on_zona_de_coleta_area_entered(area):
	if area.is_in_group("Coletavel"):
		area.liberador_de_movimento = true
		area.personagem_alvo = self

func _on_zona_de_coleta_body_entered(body):
	if body.is_in_group("Coletavel"):
		body.liberador_de_movimento = true
		body.personagem_alvo = self
