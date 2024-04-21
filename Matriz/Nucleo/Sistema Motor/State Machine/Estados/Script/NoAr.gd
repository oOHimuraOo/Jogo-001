class_name ESTADO_NO_AR
extends ESTADO_BASE

var velocidade_horizontal_alvo:float = 0
var velocidade_vertical_alvo:float = 0
var altura_inicial:float
var altura_final:float
var altura_da_queda:float 
var altura_limite:float = 200
var liberador_de_estado_escalada:bool = true

func ao_entrar_no_estado(_info:Dictionary = {}) -> void:
	super(_info)
	if _info.has("Escalando"):
		if _info["Escalando"] == true:
			liberador_de_estado_escalada = false
	else:
		liberador_de_estado_escalada = true
	
	altura_inicial = Dono_do_estado.global_position.y
	velocidade_vertical_alvo = Dono_do_estado.velocity.y
	
	Dono_do_estado.regulador_do_jogador.ultima_vez_chao = 0
	Dono_do_estado.regulador_do_jogador.ultima_vez_pulo_apertado = 0

func ao_sair_do_estado(_info:Dictionary = {}) -> void:
	Animacao.stop()
	velocidade_horizontal_alvo = 0
	velocidade_vertical_alvo = 0

func no_physics_process(_delta:float) -> void:
	lidar_com_movimento_horizontal(_delta)
	calcular_velocidade_final(_delta)
	Dono_do_estado.move_and_slide()
	lidar_com_gravidade(_delta)
	lidar_com_animacao()
	calcular_altura_de_queda()

func lidar_com_gravidade(_delta:float) -> void:
	var gravidade:float = Dono_do_estado.valores_do_jogador.gravidade_calculada
	if !Input.is_action_pressed("ui_accept") || Dono_do_estado.velocity.y >= 0:
		gravidade = Dono_do_estado.valores_do_jogador.gravidade_de_queda_acelerada
	velocidade_vertical_alvo += gravidade * _delta

func calcular_altura_de_queda() -> void:
	if Dono_do_estado.velocity.y > 0:
		altura_final = Dono_do_estado.global_position.y
		if altura_final - altura_inicial > altura_limite:
			altura_da_queda = altura_final - altura_inicial - altura_limite
		else: 
			altura_da_queda = 0

func lidar_com_animacao() -> void:
	if Dono_do_estado.velocity.y < 0:
		Animacao.play("Pulo_Subindo")
	elif Dono_do_estado.velocity.y > 0:
		Animacao.play("Pulo_Descendo")

func lidar_com_movimento_horizontal(_delta:float) -> void:
	velocidade_horizontal_alvo = lerp(Dono_do_estado.velocity.x, direcao_de_movimento * Dono_do_estado.valores_do_jogador.velocidade_de_movimento, 1 - pow(Dono_do_estado.valores_do_jogador.fator_de_aceleracao_aeria, _delta))

func calcular_velocidade_final(_delta:float) -> void:
	var velocidade_vertical_final:float = velocidade_vertical_alvo + (Dono_do_estado.valores_do_jogador.gravidade_calculada * 0.5 * _delta)
	Dono_do_estado.velocity = Vector2(velocidade_horizontal_alvo, velocidade_vertical_final)

func lidar_com_pulo() -> void:
	velocidade_vertical_alvo = Dono_do_estado.valores_do_jogador.velocidade_de_pulo

func verificar_transicao_de_estado() -> void:
	super()
	if Input.is_action_just_pressed("ui_accept"):
		if !Dono_do_estado.is_on_floor() && Dono_do_estado.valores_do_jogador.quantidade_de_pulos > Dono_do_estado.pulos_atuais:
			var info:Dictionary = {"Pulo_Extra":true}
			MDE.mudar_estado_ativo("Movimento", "Pulando", info)
			return

	if Dono_do_estado.is_on_floor():
		var info:Dictionary = {"altura_da_queda":altura_da_queda}
		MDE.mudar_estado_ativo("Movimento", "Aterrissando",info)
	
	if liberador_de_estado_escalada == true:
		if Dono_do_estado.is_on_wall_only():
			MDE.mudar_estado_ativo("Movimento", "Escalando")


