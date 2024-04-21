@icon("res://Assets/Place Holder/Icones/xp.png")
class_name POCOES
extends CharacterBody2D

@onready var textura:AnimatedSprite2D = $Textura
@onready var atualizado_de_quantidade_de_nodos = $AtualizadoDeQuantidadeDeNodos

var cura_pequena:float = 10
var cura_media:float = 25
var cura_grande:float = 50
var tipo:String = "Vida"
var tamanho:String = "Pequena"

var nodos_de_pocoes:Array
var contador_de_pocoes:int
var pocoes_limite:int = 10

var liberador_de_movimento:bool = false
var personagem_alvo:PERSONAGEM_BASE
var velocidade_de_movimento:float = 400
var fator_de_aceleracao:float = 0.5

func _ready():
	nodos_de_pocoes = get_tree().get_nodes_in_group("Pocoes")
	contador_de_pocoes = nodos_de_pocoes.size()

func _process(_delta:float) -> void:
	pass

func _physics_process(delta:float) -> void:
	if liberador_de_movimento == true:
		if personagem_alvo.morto == false:
			mover_ate_alvo(delta)
	else:
		velocity = Vector2.ZERO
	move_and_slide()

func mover_ate_alvo(delta:float) -> void:
	var direcao_de_movimento = (personagem_alvo.position - position).normalized()
	var velocidade_alvo = lerp(velocity, direcao_de_movimento * velocidade_de_movimento, 1 - pow(fator_de_aceleracao, delta))
	var distancia_ate_alvo = self.position - personagem_alvo.position
	
	if distancia_ate_alvo.x > 10 || distancia_ate_alvo.x < -10 || distancia_ate_alvo.y > 10 || distancia_ate_alvo.y < -10:
		velocity = velocidade_alvo
	else:
		velocity = Vector2.ZERO
		liberador_de_movimento = false
		consumir_pocao(tipo,tamanho)

func consumir_pocao(Pocao_de:String = "Vida", Tamanho_da_Pocao:String = "Pequena") -> void:
	if Pocao_de == "Vida":
		if Tamanho_da_Pocao == "Pequena":
			var valor_curado:float = (cura_pequena/100) * personagem_alvo.barra_de_vida.vida_maxima
			personagem_alvo.barra_de_vida.ganhar_vida(valor_curado)
		elif Tamanho_da_Pocao == "Medio":
			var valor_curado:float = (cura_media/100) * personagem_alvo.barra_de_vida.vida_maxima
			personagem_alvo.barra_de_vida.ganhar_vida(valor_curado)
		elif Tamanho_da_Pocao == "Grande":
			var valor_curado:float = (cura_grande/100) * personagem_alvo.barra_de_vida.vida_maxima
			personagem_alvo.barra_de_vida.ganhar_vida(valor_curado)
	elif Pocao_de == "Mana":
		if Tamanho_da_Pocao == "Pequena":
			var valor_curado:float = (cura_pequena/100) * personagem_alvo.barra_de_mana.mana_maxima
			personagem_alvo.barra_de_mana.ganhar_mana(valor_curado)
		elif Tamanho_da_Pocao == "Medio":
			var valor_curado:float = (cura_media/100) * personagem_alvo.barra_de_mana.mana_maxima
			personagem_alvo.barra_de_mana.ganhar_mana(valor_curado)
		elif Tamanho_da_Pocao == "Grande":
			var valor_curado:float = (cura_grande/100) * personagem_alvo.barra_de_mana.mana_maxima
			personagem_alvo.barra_de_mana.ganhar_mana(valor_curado)
	elif Pocao_de == "Estamina":
		if Tamanho_da_Pocao == "Pequena":
			var valor_curado:float = (cura_pequena/100) * personagem_alvo.barra_de_estamina.estamina_maxima
			personagem_alvo.barra_de_estamina.ganhar_estamina(valor_curado)
		elif Tamanho_da_Pocao == "Medio":
			var valor_curado:float = (cura_media/100) * personagem_alvo.barra_de_estamina.estamina_maxima
			personagem_alvo.barra_de_estamina.ganhar_estamina(valor_curado)
		elif Tamanho_da_Pocao == "Grande":
			var valor_curado:float = (cura_grande/100) * personagem_alvo.barra_de_estamina.estamina_maxima
			personagem_alvo.barra_de_estamina.ganhar_estamina(valor_curado)
	self.queue_free()

func _on_atualizado_de_quantidade_de_nodos_timeout():
	nodos_de_pocoes = get_tree().get_nodes_in_group("Pocoes")
	contador_de_pocoes = nodos_de_pocoes.size()

func atualizar_textura_e_informacao(Pocao_de:String = "Vida", Tamanho_da_Pocao:String = "Pequena") -> void:
	tipo = Pocao_de
	tamanho = Tamanho_da_Pocao
	if Pocao_de == "Vida":
		if Tamanho_da_Pocao == "Pequena":
			textura.play("Pocao_de_vida_pequena")
		elif Tamanho_da_Pocao == "Medio":
			textura.play("Pocao_de_vida_media")
		elif Tamanho_da_Pocao == "Grande":
			textura.play("Pocao_de_vida_grande")
	elif Pocao_de == "Mana":
		if Tamanho_da_Pocao == "Pequena":
			textura.play("Pocao_de_mana_pequena")
		elif Tamanho_da_Pocao == "Medio":
			textura.play("Pocao_de_mana_media")
		elif Tamanho_da_Pocao == "Grande":
			textura.play("Pocao_de_mana_grande")
	elif Pocao_de == "Estamina":
		if Tamanho_da_Pocao == "Pequena":
			textura.play("Pocao_de_estamina_pequena")
		elif Tamanho_da_Pocao == "Medio":
			textura.play("Pocao_de_estamina_media")
		elif Tamanho_da_Pocao == "Grande":
			textura.play("Pocao_de_estamina_grande")
