@icon("res://Assets/Place Holder/Icones/Ak47.png")
class_name ARMA_BASICA_DE_ATAQUE_EM_AREA
extends Node2D

var personagem:PERSONAGEM_BASE

@onready var textura:Sprite2D = $Textura
@onready var ponto_de_saida:Marker2D = $PontoDeSaida
@onready var temporizador_de_balas_por_segundo:Timer = $Cooldown
@onready var mira:AnimatedSprite2D = $mira

var rotacao_em_uso:float
var rotacao_em_descanso:float
var alcance_maximo:float = 200

var posicao_local_alvo:Vector2

var balas_por_segundo:float = 1
var tempo_de_espera_do_temporizador:float = 0

var index:int
var nivel:int
var nome:String
var ativa:bool = true
var tipo:String = "Perfurante"
var dano:float = 10
var raio_minimo:float
var raio_maximo:float
var consumo_de_mana:float
var descricao:String

var liberador_de_mira_passiva:bool = true
var multiplicador_de_consumo_de_mana:float = 1

func _ready():
	inicializar_valores()

func inicializar_valores() -> void:
	if ativa == true:
		tempo_de_espera_do_temporizador = 1/balas_por_segundo
		temporizador_de_balas_por_segundo.wait_time = tempo_de_espera_do_temporizador
	else:
		balas_por_segundo = balas_por_segundo / 2
		tempo_de_espera_do_temporizador = 1/balas_por_segundo
		temporizador_de_balas_por_segundo.wait_time = tempo_de_espera_do_temporizador

func _process(delta):
	if personagem.morto == false:
		if ativa == true:
			ajustar_mira_ativa(get_local_mouse_position().x)
			arma_ativa_controlador(delta)
		else:
			ajustar_mira_passiva(alcance_maximo/randi_range(1, (alcance_maximo/100)))
			arma_passiva_controlador(delta)

func ajustar_mira_ativa(nova_posicao_x:float) -> void:
	if nova_posicao_x > alcance_maximo:
		nova_posicao_x = alcance_maximo
	ponto_de_saida.position.x = nova_posicao_x
	mira.position.x = ponto_de_saida.position.x

func ajustar_mira_passiva(nova_posicao_x:float) -> void:
	if liberador_de_mira_passiva == true:
		liberador_de_mira_passiva = false
		if nova_posicao_x > alcance_maximo:
			nova_posicao_x = alcance_maximo
		ponto_de_saida.position.x = nova_posicao_x
		mira.position.x = ponto_de_saida.position.x

func arma_ativa_controlador(delta) -> void:
	if personagem.maquina_de_estados.get_child(1).name == personagem.maquina_de_estados.estado_ativo.get_parent().name:
		self.show()
		atualizar_rotacao_da_arma()
		if Input.is_action_pressed("Atirar"):
			lidar_com_tiros(delta)
	else:
		self.hide()
		rotation = rotacao_em_descanso
		textura.flip_v = false

func arma_passiva_controlador(delta) -> void:
	if get_parent().get_child(0) == self:
		self.show()
	else:
		self.hide()
	atualizar_rotacao_da_arma()
	if atirar_automaticamente() == true:
		lidar_com_tiros(delta)

func atirar_automaticamente() -> bool:
	return true

func lidar_com_tiros(_delta:float) -> void:
	if !temporizador_de_balas_por_segundo.is_stopped():
		return
	if personagem.barra_de_mana.mana_atual < consumo_de_mana:
		return
	
	var tiro_instancia:TIRO_DE_ATAQUE_EM_AREA = DATA.CON.Tiro_De_Ataque_Em_Area.instantiate()
	personagem.sistema_de_dano.calculadora_de_dano_de_mana(false,consumo_de_mana,multiplicador_de_consumo_de_mana)
	tiro_instancia.personagem = personagem
	tiro_instancia.tipo = tipo
	tiro_instancia.dano = dano
	tiro_instancia.raio_minimo = raio_minimo
	tiro_instancia.raio_maximo = raio_maximo
	tiro_instancia.global_position = ponto_de_saida.global_position
	add_child(tiro_instancia)

	temporizador_de_balas_por_segundo.start()
	liberador_de_mira_passiva = true

func atualizar_rotacao_da_arma() -> void:
	rotation = (get_global_mouse_position() - global_position).angle()
	if get_global_mouse_position().x < global_position.x:
		textura.flip_v = true
	else:
		textura.flip_v = false

