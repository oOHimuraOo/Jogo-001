class_name ESTADO_ANDANDO
extends ESTADO_BASE

var velocidade_de_movimento:float
var velocidade_horizontal_alvo:float = 0
var pode_regenerar_fator_1:bool = false
var fator_upgrade:float = 1
var estamina_consumida:float = 10

func ao_entrar_no_estado(_info:Dictionary = {}) -> void:
	super(_info)
	Animacao.play(self.name)
	velocidade_de_movimento = Dono_do_estado.valores_do_jogador.velocidade_de_movimento
	regeneracao_cooldown_ativador()

func regeneracao_cooldown_ativador():
	var timer_1 = Timer.new()
	timer_1.wait_time = 2
	timer_1.one_shot = true
	timer_1.timeout.connect(quando_timer_1_der_timeout)
	add_child(timer_1)
	timer_1.start()

func quando_timer_1_der_timeout():
	pode_regenerar_fator_1 = true
	fator_upgrade += 1

func no_process(delta:float) -> void:
	super(delta)
	if pode_regenerar_fator_1 == true:
		pode_regenerar_fator_1 = false
		regeneracao()

func regeneracao():
	var estamina_regenerada:float = 0.5
	Dono_do_estado.sistema_de_dano.calculadora_de_dano_de_estamina(true, Dono_do_estado.valores_do_jogador.destreza,estamina_regenerada, fator_upgrade)
	get_child(0).start()

func ao_sair_do_estado(_info:Dictionary = {}) -> void:
	get_child(0).queue_free()
	fator_upgrade = 1

func no_physics_process(delta:float) -> void:
	lidar_com_movimento_horizontal(delta)
	lidar_com_som_do_personagem()
	Dono_do_estado.velocity.x = velocidade_horizontal_alvo 
	Dono_do_estado.move_and_slide()

func lidar_com_som_do_personagem() -> void:
	match Animacao.frame:
		0:
			DATA.SON.tocar_efeitos_sonoros_ecolocalisaveis(Dono_do_estado, Dono_do_estado.global_position, lista_de_efeitos_sonoros.pick_random())

func lidar_com_movimento_horizontal(delta:float) -> void:
	if sign(direcao_de_movimento) != sign(Dono_do_estado.velocity.x) && Dono_do_estado.velocity.x != 0:
		velocidade_horizontal_alvo = 0
	else:
		velocidade_horizontal_alvo = lerp(Dono_do_estado.velocity.x, direcao_de_movimento * Dono_do_estado.valores_do_jogador.velocidade_de_movimento, 1 - pow(Dono_do_estado.valores_do_jogador.fator_de_aceleracao, delta))

func verificar_transicao_de_estado():
	super()
	#var Camera:CAMERA_CONTROLE = get_tree().get_first_node_in_group("Camera")
	if Dono_do_estado.regulador_do_jogador.ultima_vez_pulo_apertado + Dono_do_estado.regulador_do_jogador.regulador_de_tempo_de_pulo > Time.get_ticks_msec():
		MDE.mudar_estado_ativo("Movimento", "Pulando")
		return
	
	if Dono_do_estado.regulador_do_jogador.ultima_vez_chao + Dono_do_estado.regulador_do_jogador.tempo_limite_de_efeito_coyote < Time.get_ticks_msec():
		MDE.mudar_estado_ativo("Especial", "NoAr")
		return
	
	if direcao_de_movimento == 0:
		MDE.mudar_estado_ativo("Movimento", "Parado")
		return

	if Input.is_action_pressed("S"):
		MDE.mudar_estado_ativo("Movimento", "Agachado")
		return
	
	if Input.is_action_pressed("Ctrl"):
		MDE.mudar_estado_ativo("Movimento", "Correndo")

