class_name ESTADO_ATERRISSANDO
extends ESTADO_BASE

var Animacao_de_aterrissar_terminada:bool = false
var rolou:bool

func ao_entrar_no_estado(_info:Dictionary = {}) -> void:
	super(_info)
	Dono_do_estado.pulos_atuais = 0
	Animacao.animation_finished.connect(quando_animacao_acabar)
	if _info["altura_da_queda"] == 0:
		if Input.is_action_pressed("Shift"):
			Animacao_de_aterrissar_terminada = false
			rolou = true
			Animacao.play(self.name)
			instanciar_particula()
		else:
			Animacao_de_aterrissar_terminada = false
			rolou = false
			Animacao.play(self.name)
			instanciar_particula()
	else:
		if Input.is_action_pressed("Shift"):
			Animacao_de_aterrissar_terminada = false
			rolou = true
			instanciar_particula()
		else:
			Animacao_de_aterrissar_terminada = false
			Animacao.play(self.name + "_com_dano")
			instanciar_particula()
		causar_dano_de_queda(_info["altura_da_queda"])

func causar_dano_de_queda(Dano:float) -> void:
	var dano_real:float
	if rolou == true:
		dano_real = Dano / 2
		if dano_real >= 150:
			dano_real = 150
	else:
		dano_real = Dano
		if dano_real >= 300:
			dano_real = 300
	Dono_do_estado.sistema_de_dano.calculadora_de_dano_de_vida(false, "Contusao", Dono_do_estado.valores_do_jogador.constituicao, dano_real)

func instanciar_particula():
	var particula_instancia = DATA.CON.Particula_de_pulo.instantiate()
	particula_instancia.position = Dono_do_estado.position + Vector2(0,16)
	add_child(particula_instancia)

func ao_sair_do_estado(_info:Dictionary = {}) -> void:
	Animacao.animation_finished.disconnect(quando_animacao_acabar)
	Dono_do_estado.colisao_da_hurtbox.disabled = false
	rolou = false

func quando_animacao_acabar() -> void:
	Animacao_de_aterrissar_terminada = true

func no_physics_process(_delta:float) -> void:
	lidar_com_som_do_personagem()
	if Animacao_de_aterrissar_terminada == true:
		Dono_do_estado.move_and_slide()
	if rolou == true:
		Animacao.play("Rolando")
		Dono_do_estado.colisao_da_hurtbox.disabled = true
		Dono_do_estado.move_and_slide()

func lidar_com_som_do_personagem() -> void:
	match Animacao.frame:
		0:
			if rolou == false:
				DATA.SON.tocar_efeitos_sonoros_ecolocalisaveis(Dono_do_estado, Dono_do_estado.global_position, lista_de_efeitos_sonoros.pick_random())

func verificar_transicao_de_estado() -> void:
	super()
	if Animacao_de_aterrissar_terminada == true:
		if direcao_de_movimento != 0:
			MDE.mudar_estado_ativo("Movimento", "Andando")
			return
		if direcao_de_movimento == 0:
			MDE.mudar_estado_ativo("Movimento", "Parado")
			return
	
	if Dono_do_estado.regulador_do_jogador.ultima_vez_pulo_apertado + Dono_do_estado.regulador_do_jogador.regulador_de_tempo_de_pulo > Time.get_ticks_msec():
		var info:Dictionary = {}
		MDE.mudar_estado_ativo("Movimento", "Pulando", info)
		return




