@icon("res://Assets/Place Holder/Icones/enemy-ghost-icon.png")
class_name INIMIGO_BASE
extends CharacterBody2D

@onready var textura = $Textura
@onready var hurt_box = $HurtBox
@onready var hit_box = $HitBox
@onready var ativador_de_ataque = $AtivadorDeAtaque
@onready var organizador_de_mecanicas = $OrganizadorDeMecanicas
@onready var organizador_de_informativo = $OrganizadorDeInformativo
@onready var organizador_de_audios = $OrganizadorDeAudios
@onready var liberador_de_movimento = $LiberadorDeMovimento
@onready var colisao_da_hurt_box = $HurtBox/ColisaoDaHurtBox
@onready var colisao_da_hit_box = $HitBox/ColisaoDaHitBox

var valores_do_inimigo:VALORES_DO_INIMIGO
var regulador_do_inimigo:REGULADOR_DO_INIMIGO
var sistema_de_dano:SISTEMA_DE_DANO

var barra_de_vida:BARRA_DE_VIDA

var pode_atacar:bool = false
var colisao_detectada:bool = false
var morto:bool = false
var personagem:PERSONAGEM_BASE

var index:int
var pode_mover:bool = true

func _ready():
	randomize()
	carregar_informacoes_de_inimigo(index)

func carregar_informacoes_de_inimigo(indice:int) -> void:
	instanciar_mecanicas()
	valores_do_inimigo.nivel = 1
	valores_do_inimigo.vida_incial = DATA.DAT.DTB_INIM[str(indice)]["Vida"]
	valores_do_inimigo.forca = DATA.DAT.DTB_INIM[str(indice)]["Forca"]
	valores_do_inimigo.destreza = DATA.DAT.DTB_INIM[str(indice)]["Destreza"]
	valores_do_inimigo.constituicao = DATA.DAT.DTB_INIM[str(indice)]["Constituicao"]
	valores_do_inimigo.dano_base = DATA.DAT.DTB_INIM[str(indice)]["dano_base"]
	valores_do_inimigo.tipo_de_dano = DATA.DAT.DTB_INIM[str(indice)]["tipo_de_dano"]
	valores_do_inimigo.fator_de_dano_especial = DATA.DAT.DTB_INIM[str(indice)]["fator_de_dano_especial"]
	valores_do_inimigo.barra_afetada = DATA.DAT.DTB_INIM[str(indice)]["barra_afetada"]
	valores_do_inimigo.velocidade_de_movimento = DATA.DAT.DTB_INIM[str(indice)]["velocidade_de_movimento"]
	valores_do_inimigo.fator_de_aceleracao = DATA.DAT.DTB_INIM[str(indice)]["fator_de_aceleracao"]
	valores_do_inimigo.xp_dropada = DATA.DAT.DTB_INIM[str(indice)]["xp_dropada"]
	valores_do_inimigo.dinheiro_dropado = DATA.DAT.DTB_INIM[str(indice)]["dinheiro_dropado"]
	valores_do_inimigo.chance_de_drop_de_ouro = DATA.DAT.DTB_INIM[str(indice)]["chance_de_drop_de_ouro"]
	valores_do_inimigo.chance_de_drop_de_potion = DATA.DAT.DTB_INIM[str(indice)]["chance_de_drop_de_potion"]
	valores_do_inimigo.chance_de_drop_de_presente = DATA.DAT.DTB_INIM[str(indice)]["chance_de_drop_de_presente"]
	self.set_name("inimigo_" + DATA.DAT.DTB_INIM[str(indice)]["Nome"])
	instanciar_informativos()
	barra_de_vida.vida_zerada.connect(morreu)
	ativador_de_ataque.wait_time = DATA.DAT.DTB_INIM[str(indice)]["cooldown_de_ataque"]
	mudar_cor_do_inimigo()

func mudar_cor_do_inimigo() -> void:
	match valores_do_inimigo.barra_afetada:
		"Vida":
			modulate = Color("ff0000")
		"Mana":
			modulate = Color("00ff00")
		"Estamina":
			modulate = Color("0000ff")

func morreu(entidade:Node2D) -> void:
	entidade.morto = true
	colisao_da_hit_box.set_deferred("disabled",true)
	colisao_da_hurt_box.set_deferred("disabled",true)
	entidade.textura.play("morto")

func instanciar_informativos() -> void:
	if valores_do_inimigo.vida_incial != null:
		var barra_instancia = DATA.CON.Barra_de_vida.instantiate()
		barra_instancia.inimigo = true
		organizador_de_informativo.add_child(barra_instancia)
		organizador_de_informativo.barra_de_vida = barra_instancia
		barra_de_vida = barra_instancia

func instanciar_mecanicas() -> void:
	if organizador_de_mecanicas.get_child_count() == 0:
		var valor_instancia = DATA.CON.Valores_do_inimigo.instantiate()
		organizador_de_mecanicas.add_child(valor_instancia)
		valores_do_inimigo = valor_instancia
		valor_instancia.personagem = self
		var regulador_instancia = DATA.CON.Regulador_do_inimigo.instantiate()
		organizador_de_mecanicas.add_child(regulador_instancia)
		regulador_do_inimigo = regulador_instancia
		regulador_instancia.personagem = self
		var sistema_de_dano_instancia = DATA.CON.Sistema_de_dano.instantiate()
		organizador_de_mecanicas.add_child(sistema_de_dano_instancia)
		sistema_de_dano = sistema_de_dano_instancia
		sistema_de_dano.Receptor = self

func atacar() -> void:
	var areas:Array = hit_box.get_overlapping_areas()
	if pode_atacar == false && ativador_de_ataque.is_stopped():
		ativador_de_ataque.start()
		return
	
	for area in areas:
		if area.get_parent() is PERSONAGEM_BASE:
			if pode_atacar == true:
				causar_dano(area.get_parent(), valores_do_inimigo.barra_afetada)
				pode_atacar = false
				return
		
func causar_dano(alvo:Node2D, Barra:String) -> void:
	match Barra:
		"Vida":
			alvo.sistema_de_dano.calculadora_de_dano_de_vida(false, valores_do_inimigo.tipo_de_dano, valores_do_inimigo.forca, valores_do_inimigo.dano_base)
		"Mana":
			alvo.sistema_de_dano.calculadora_de_dano_de_mana(false, valores_do_inimigo.dano_base, valores_do_inimigo.fator_de_dano_especial)
		"Estamina":
			alvo.sistema_de_dano.calculadora_de_dano_de_estamina(false, valores_do_inimigo.forca, valores_do_inimigo.dano_base, valores_do_inimigo.fator_de_dano_especial)

func _on_ativador_de_ataque_timeout():
	pode_atacar = true

func _process(_delta):
	if morto == false:
		if colisao_detectada == true:
			atacar()

func _on_hit_box_area_entered(_area):
	colisao_detectada = true

func _on_hit_box_area_exited(_area):
	colisao_detectada = false

func _on_textura_animation_finished():
	dropar_experiencia(valores_do_inimigo.xp_dropada)
	verificar_se_vai_dropar_dinheiro()
	verificar_se_vai_dropar_pocao()
	verificar_se_vai_dropar_presente()
	self.queue_free()

func dropar_experiencia(Xp:float) -> void:
	var xp_instancia:PONTOS_DE_EXPERIENCIA = DATA.CON.Xp.instantiate()
	xp_instancia.xp_inicial = Xp
	xp_instancia.xp_atual = Xp
	xp_instancia.position = position
	find_parent("Nova_Cena_Teste").find_child("Itens").find_child("Xp").add_child(xp_instancia)

func verificar_se_vai_dropar_dinheiro() -> void:
	var resultado_da_rolagem:int = randi_range(0,100)
	if resultado_da_rolagem <= valores_do_inimigo.chance_de_drop_de_ouro:
		dropar_dinheiro(valores_do_inimigo.dinheiro_dropado)

func verificar_se_vai_dropar_pocao() -> void:
	var resultado_da_rolagem:int = randi_range(0,100)
	if resultado_da_rolagem <= valores_do_inimigo.chance_de_drop_de_potion:
		dropar_pocao()

func verificar_se_vai_dropar_presente() -> void:
	var resultado_da_rolagem:int = randi_range(0,100)
	if resultado_da_rolagem <= valores_do_inimigo.chance_de_drop_de_presente:
		dropar_presente()

func dropar_pocao() -> void:
	match valores_do_inimigo.barra_afetada:
		"Vida":
			var pocao_instancia:POCOES = DATA.CON.Pocao_Vida_Pequena.instantiate()
			pocao_instancia.position = position + Vector2(-25,0)
			find_parent("Nova_Cena_Teste").find_child("Itens").find_child("Consumiveis").add_child(pocao_instancia)
		"Estamina":
			var pocao_instancia:POCOES = DATA.CON.Pocao_Mana_Pequena.instantiate()
			pocao_instancia.position = position + Vector2(-25,0)
			find_parent("Nova_Cena_Teste").find_child("Itens").find_child("Consumiveis").add_child(pocao_instancia)
		"Mana":
			var pocao_instancia:POCOES = DATA.CON.Pocao_Estamina_Pequena.instantiate()
			pocao_instancia.position = position + Vector2(-25,0)
			find_parent("Nova_Cena_Teste").find_child("Itens").find_child("Consumiveis").add_child(pocao_instancia)

func dropar_presente() -> void:
	print("dropei um presente")

func dropar_dinheiro(valor:int) -> void:
	var dinheiro_instancia:DINHEIRO = DATA.CON.Dinheiro.instantiate()
	dinheiro_instancia.dinheiro = valor
	dinheiro_instancia.position = position + Vector2(25,0)
	find_parent("Nova_Cena_Teste").find_child("Itens").find_child("DinDin").add_child(dinheiro_instancia)

func _physics_process(delta:float) -> void:
	if morto == false:
		movimentar_inimigo(delta)

func movimentar_inimigo(delta:float) -> void:
	var direcao_de_movimento = (personagem.position - position).normalized()
	var velocidade_alvo = direcao_de_movimento * valores_do_inimigo.velocidade_de_movimento
	var distancia_ate_alvo = self.position - personagem.position
	var angulo_de_rotacao = get_angle_to(personagem.position)
	
	if pode_mover == true:
		if distancia_ate_alvo.y > 10 || distancia_ate_alvo.y < -10:
			velocity.x = lerp(velocity.x, velocidade_alvo.x / 2, 1 - pow(valores_do_inimigo.fator_de_aceleracao, delta))
			velocity.y = velocidade_alvo.y
			textura.rotation = angulo_de_rotacao
		elif distancia_ate_alvo.y <= 10 || distancia_ate_alvo.y >= -10:
			if distancia_ate_alvo.x > 10 || distancia_ate_alvo.x < -10:
				velocity.y = 0
				velocity.x = velocidade_alvo.x
				textura.rotation = angulo_de_rotacao
			else:
				velocity = Vector2.ZERO
				pode_mover = false
				liberador_de_movimento.start()
		move_and_slide()
		
	if distancia_ate_alvo.x > 0:
		textura.flip_v = true
	if distancia_ate_alvo.x < 0:
		textura.flip_v = false

func _on_liberador_de_movimento_timeout():
	pode_mover = true
