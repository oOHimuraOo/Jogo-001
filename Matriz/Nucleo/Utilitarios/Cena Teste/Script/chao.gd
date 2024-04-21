class_name CHAO
extends StaticBody2D

var gerenciador_de_jogo:GERENCIADOR_DE_JOGO 
var interface_pontos:SISTEMA_DE_LEVEL_UP
var personagem:PERSONAGEM_BASE

var player_no_chão:bool = false
var ja_pisou:Array = []

func _ready():
	gerenciador_de_jogo = find_parent("Nova_Cena_Teste")
	await gerenciador_de_jogo.ready
	interface_pontos = gerenciador_de_jogo.find_child("InterfaceDeMelhoriaDeAtributo")
	personagem = gerenciador_de_jogo.find_child("Personagem").get_child(0)

func _on_area_2d_body_entered(body):
	if self.rotation == 0 and body is PERSONAGEM_BASE:
		player_no_chão = true

func _process(_delta):
	if !ja_pisou.has(self):
		if player_no_chão == true:
			player_no_chão = false
			interface_pontos.valor_altura_anterior = interface_pontos.valor_altura_atual
			interface_pontos.valor_altura_atual = personagem.global_position.y
			interface_pontos.calcular_pontos_de_altura()
			ja_pisou += [self]
