class_name ESTADO_COMBATE_ANDANDO
extends ESTADO_BASE

var velocidade_de_movimento:float
var velocidade_horizontal_alvo:float = 0
var pode_regenerar_fator_1:bool = false
var fator_upgrade:float = 1
var estamina_consumida:float = 10

func ao_entrar_no_estado(_info:Dictionary = {}) -> void:
	super(_info)
	Animacao.play("Andando")
	velocidade_de_movimento = Dono_do_estado.valores_do_jogador.velocidade_de_movimento
	regeneracao_cooldown_ativador()

func no_process(_delta:float) -> void:
	super(_delta)
	if pode_regenerar_fator_1 == true:
		pode_regenerar_fator_1 = false
		regeneracao()

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

func regeneracao():
	var vida_regenerada = 2
	var mana_regenerada = 1
	var estamina_regenerada = 0.5
		
	Dono_do_estado.sistema_de_dano.calculadora_de_dano_de_vida(true, "Cura", Dono_do_estado.valores_do_jogador.constituicao, vida_regenerada, fator_upgrade)
	Dono_do_estado.sistema_de_dano.calculadora_de_dano_de_mana(true, mana_regenerada, fator_upgrade)
	Dono_do_estado.sistema_de_dano.calculadora_de_dano_de_estamina(true, Dono_do_estado.valores_do_jogador.destreza, estamina_regenerada, fator_upgrade)
	
	get_child(0).start()

func quando_timer_1_der_timeout():
	pode_regenerar_fator_1 = true
	fator_upgrade += 1

func no_physics_process(delta:float) -> void:
	lidar_com_movimento_horizontal(delta)
	lidar_com_direcao_do_olhar()
	Dono_do_estado.velocity.x = velocidade_horizontal_alvo 
	Dono_do_estado.move_and_slide()

func lidar_com_direcao_do_olhar():
	var Posicao_do_mouse:Vector2 = Dono_do_estado.get_local_mouse_position()
	if Posicao_do_mouse.x > 0:
		Animacao.flip_h = false
	else:
		Animacao.flip_h = true

func lidar_com_direcao_da_animacao() -> void:
	pass

func lidar_com_movimento_horizontal(delta:float) -> void:
	if sign(direcao_de_movimento) != sign(Dono_do_estado.velocity.x) && Dono_do_estado.velocity.x != 0:
		velocidade_horizontal_alvo = 0
	else:
		velocidade_horizontal_alvo = lerp(Dono_do_estado.velocity.x, direcao_de_movimento * Dono_do_estado.valores_do_jogador.velocidade_de_movimento_em_combate, 1 - pow(Dono_do_estado.valores_do_jogador.fator_de_aceleracao, delta))

func verificar_transicao_de_estado():
	super()
	#var Camera:CAMERA_CONTROLE = get_tree().get_first_node_in_group("Camera")
	if Input.is_action_just_pressed("Q"):
		MDE.mudar_estado_ativo("Movimento", "Parado")
		return
	
	if Dono_do_estado.regulador_do_jogador.ultima_vez_pulo_apertado + Dono_do_estado.regulador_do_jogador.regulador_de_tempo_de_pulo > Time.get_ticks_msec() && Dono_do_estado.barra_de_estamina.estamina_atual >= estamina_consumida:
		var info:Dictionary = {"Estamina": estamina_consumida}
		MDE.mudar_estado_ativo("Combate", "Esquivando", info)
		return
	
	if Dono_do_estado.regulador_do_jogador.ultima_vez_chao + Dono_do_estado.regulador_do_jogador.tempo_limite_de_efeito_coyote < Time.get_ticks_msec():
		MDE.mudar_estado_ativo("Especial", "NoAr")
		return
	
	if direcao_de_movimento == 0:
		MDE.mudar_estado_ativo("Combate", "Combate")
		return

	if Input.is_action_pressed("Ctrl") && Dono_do_estado.barra_de_estamina.estamina_atual >= estamina_consumida / 2:
		var info:Dictionary = {"Estamina": estamina_consumida / 2}
		MDE.mudar_estado_ativo("Combate", "CombateCorrendo", info)
		return
	
	if Input.is_action_pressed("Mirar"):
		MDE.mudar_estado_ativo("Combate", "Mirando")
		return
	

