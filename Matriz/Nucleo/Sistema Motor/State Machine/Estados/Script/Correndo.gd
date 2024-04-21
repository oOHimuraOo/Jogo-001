class_name ESTADO_CORRENDO
extends ESTADO_BASE

var velocidade_de_movimento:float
var velocidade_horizontal_padrao:float

var pode_consumir:bool
var estamina_consumida:float = 1
var fator_upgrade:float = 0.5

var multiplicador_de_velocidade:float = 4
var redutor_de_velocidade:float = 3

func ao_entrar_no_estado(_info:Dictionary = {}) -> void:
	super(_info)
	pode_consumir = true
	consumir_estamina_cooldown_ativador()

func consumir_estamina_cooldown_ativador() -> void:
	var timer = Timer.new()
	timer.wait_time = 1
	timer.one_shot = true
	timer.timeout.connect(quando_timer_der_timeout)
	add_child(timer)
	timer.start()

func quando_timer_der_timeout():
	pode_consumir = true
	fator_upgrade += 0.05

func ao_sair_do_estado(_info:Dictionary = {}) -> void:
	get_child(0).queue_free()
	fator_upgrade = 0.5

func no_physics_process(_delta:float) -> void:
	calcular_velocidade_final()
	consumir_estamina()
	lidar_com_animacao()
	lidar_com_movimento_horizontal(_delta)
	lidar_com_som_do_personagem()
	Dono_do_estado.velocity.x = velocidade_horizontal_padrao 
	Dono_do_estado.move_and_slide()

func lidar_com_som_do_personagem() -> void:
	match Animacao.frame:
		0,3:
			DATA.SON.tocar_efeitos_sonoros_ecolocalisaveis(Dono_do_estado, Dono_do_estado.global_position, lista_de_efeitos_sonoros.pick_random())

func consumir_estamina() -> void:
	if pode_consumir == true:
		pode_consumir = false
		Dono_do_estado.sistema_de_dano.calculadora_de_dano_de_estamina(false, Dono_do_estado.valores_do_jogador.destreza, estamina_consumida, fator_upgrade)
		get_child(0).start()

func lidar_com_animacao() -> void:
	if Input.is_action_pressed("Ctrl"):
		Animacao.play(self.name)

func calcular_velocidade_final() -> void:
	if Dono_do_estado.barra_de_estamina.estamina_atual != 0:
		velocidade_de_movimento = Dono_do_estado.valores_do_jogador.velocidade_de_movimento * multiplicador_de_velocidade
	else:
		velocidade_de_movimento = (Dono_do_estado.valores_do_jogador.velocidade_de_movimento * multiplicador_de_velocidade) / redutor_de_velocidade

func lidar_com_movimento_horizontal(delta:float) -> void:
	if sign(direcao_de_movimento) != sign(Dono_do_estado.velocity.x) && Dono_do_estado.velocity.x != 0:
		velocidade_horizontal_padrao = 0
	else:
		velocidade_horizontal_padrao = lerp(Dono_do_estado.velocity.x, direcao_de_movimento * velocidade_de_movimento, 1 - pow(Dono_do_estado.valores_do_jogador.fator_de_aceleracao, delta))

func verificar_transicao_de_estado() -> void:
	super()
	if !Input.is_action_pressed("Ctrl") && direcao_de_movimento != 0:
		MDE.mudar_estado_ativo("Movimento", "Andando")
		return
	
	if !Dono_do_estado.is_on_floor():
		MDE.mudar_estado_ativo("Especial", "NoAr")
		return
	
	if Dono_do_estado.is_on_floor() && Input.is_action_pressed("ui_accept"):
		MDE.mudar_estado_ativo("Movimento", "Pulando")
		return
	
	if direcao_de_movimento == 0:
		MDE.mudar_estado_ativo("Movimento", "Parado")
		return

