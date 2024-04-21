@icon("res://Assets/Place Holder/Icones/Ak47.png")
class_name TIRO_DE_ATAQUE_EM_AREA
extends Node2D

@onready var textura = $Textura
@onready var area_de_efeito = $AreaDeEfeito
@onready var detector = $AreaDeEfeito/detector

var personagem:PERSONAGEM_BASE
var tipo:String
var dano:float
var raio_minimo:float
var raio_maximo:float

var contagem_de_frame:float = 0
var raio_atual:float 
var fator_de_ampliacao:float 

func _ready():
	personagem = get_tree().get_first_node_in_group("Jogador")
	calcular_fator_de_ampliacao()

func calcular_fator_de_ampliacao() -> void:
	fator_de_ampliacao = raio_maximo / 100

func _process(_delta):
	ajustar_tamanho_de_raio()

func ajustar_tamanho_de_raio() -> void:
	if raio_atual < raio_minimo:
		raio_atual = raio_minimo
	if raio_atual > raio_maximo:
		raio_atual = raio_maximo
	
	detector.shape.radius = raio_atual

func _on_animated_sprite_2d_frame_changed():
	contagem_de_frame += 1
	if contagem_de_frame <= 10:
		raio_atual += fator_de_ampliacao
	elif contagem_de_frame <= 20:
		raio_atual += fator_de_ampliacao * 2
	elif contagem_de_frame <= 30:
		raio_atual += fator_de_ampliacao * 3
	elif contagem_de_frame <= 40:
		raio_atual += fator_de_ampliacao * 4
	elif contagem_de_frame <= 50:
		raio_atual -= fator_de_ampliacao * 4
	elif contagem_de_frame <= 60:
		raio_atual -= fator_de_ampliacao * 3
	elif contagem_de_frame <= 70:
		raio_atual -= fator_de_ampliacao * 2
	elif contagem_de_frame <= 80:
		raio_atual -= fator_de_ampliacao
	else:
		raio_atual = 0

func _on_area_de_efeito_area_entered(area):
	if area.is_in_group("Inimigo"):
		var inimigo_temp:INIMIGO_BASE = area.get_parent()
		inimigo_temp.sistema_de_dano.calculadora_de_dano_de_vida(false,tipo,personagem.valores_do_jogador.forca,dano)

func _on_textura_animation_finished():
	self.queue_free()
