class_name ESTADO_PARADO
extends ESTADO_BASE

var pode_regenerar_fator_1:bool = false
var fator_upgrade:float = 1

func ao_entrar_no_estado(_info:Dictionary = {}) -> void:
	super(_info)
	Animacao.play(self.name)
	regeneracao_cooldown_ativador()

func ao_sair_do_estado(_info:Dictionary = {}) -> void:
	if get_child_count() > 0:
		get_child(0).queue_free()
	fator_upgrade = 1

func regeneracao_cooldown_ativador():
	if morreu == false:
		var timer_1 = Timer.new()
		timer_1.wait_time = 2
		timer_1.one_shot = true
		timer_1.timeout.connect(quando_timer_1_der_timeout)
		add_child(timer_1)
		timer_1.start()

func no_process(_delta:float) -> void:
	super(_delta)
	if pode_regenerar_fator_1 == true:
		pode_regenerar_fator_1 = false
		regeneracao()

func no_physics_process(_delta:float) -> void:
	pass

func regeneracao():
	var vida_regenerada = 2
	var mana_regenerada = 1
	var estamina_regenerada = 0.5
		
	Dono_do_estado.sistema_de_dano.calculadora_de_dano_de_vida(true, "Cura", Dono_do_estado.valores_do_jogador.constituicao, vida_regenerada, fator_upgrade)
	Dono_do_estado.sistema_de_dano.calculadora_de_dano_de_mana(true, mana_regenerada, fator_upgrade)
	Dono_do_estado.sistema_de_dano.calculadora_de_dano_de_estamina(true, Dono_do_estado.valores_do_jogador.destreza, estamina_regenerada, fator_upgrade)
	
	get_child(0).start()

func verificar_transicao_de_estado() -> void:
	super()
	#var Camera:CAMERA_CONTROLE = get_tree().get_first_node_in_group("Camera")
	if Dono_do_estado.regulador_do_jogador.ultima_vez_pulo_apertado + Dono_do_estado.regulador_do_jogador.regulador_de_tempo_de_pulo > Time.get_ticks_msec():
		var info:Dictionary = {}
		MDE.mudar_estado_ativo("Movimento", "Pulando", info)
		return
	
	if Dono_do_estado.regulador_do_jogador.ultima_vez_chao + Dono_do_estado.regulador_do_jogador.tempo_limite_de_efeito_coyote < Time.get_ticks_msec():
		var info:Dictionary = {}
		MDE.mudar_estado_ativo("Especial", "NoAr", info)
		return
	
	if direcao_de_movimento != 0:
		MDE.mudar_estado_ativo("Movimento", "Andando")
		return

	if Input.is_action_pressed("S"):
		MDE.mudar_estado_ativo("Movimento", "Agachado")
		return


func quando_timer_1_der_timeout():
	pode_regenerar_fator_1 = true
	fator_upgrade += 1

