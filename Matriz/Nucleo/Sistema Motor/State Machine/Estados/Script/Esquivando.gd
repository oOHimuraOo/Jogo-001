class_name ESTADO_ESQUIVANDO
extends ESTADO_BASE

var animacao_acabou:bool = false
var captar_posicao_do_mouse:bool = false
var estamina_consumida:float = 10
var fator_upgrade:float = 1
var modificador_de_velocidade:float = 10

func ao_entrar_no_estado(info:Dictionary = {}) -> void:
	animacao_acabou = false
	Animacao.animation_finished.connect(quando_animacao_acabar)
	Animacao.play("Rolando")
	Dono_do_estado.colisao_da_hurtbox.disabled = true
	Dono_do_estado.delimitador_de_zona_de_coleta.disabled = true
	consumir_estamina(info["Estamina"])

func consumir_estamina(Estamina:float) -> void:
	Dono_do_estado.sistema_de_dano.calculadora_de_dano_de_estamina(false, Dono_do_estado.valores_do_jogador.destreza, Estamina, fator_upgrade)

func ao_sair_do_estado(_info:Dictionary = {}) -> void:
	Animacao.animation_finished.disconnect(quando_animacao_acabar)
	Dono_do_estado.colisao_da_hurtbox.disabled = false
	Dono_do_estado.delimitador_de_zona_de_coleta.disabled = false
	captar_posicao_do_mouse = false

func quando_animacao_acabar() -> void:
	animacao_acabou = true

func no_process(_delta:float) -> void:
	super(_delta)

func no_physics_process(_delta:float) -> void:
	lidar_com_a_direcao_do_olhar()
	var Posicao_do_mouse:Vector2 = Dono_do_estado.get_local_mouse_position().normalized()
	Dono_do_estado.velocity.x += modificador_de_velocidade * Posicao_do_mouse.x
	Dono_do_estado.move_and_slide()

func lidar_com_a_direcao_do_olhar() -> void:
	var Posicao_do_mouse:Vector2 = Dono_do_estado.get_local_mouse_position()
	if captar_posicao_do_mouse == false:
		if Posicao_do_mouse.x > 0:
			Dono_do_estado.velocity.x = Dono_do_estado.valores_do_jogador.velocidade_de_movimento_mirando
			Animacao.flip_h = false
			captar_posicao_do_mouse = true
		else:
			Dono_do_estado.velocity.x = -(Dono_do_estado.valores_do_jogador.velocidade_de_movimento_mirando)
			Animacao.flip_h = true
			captar_posicao_do_mouse = true

func lidar_com_direcao_da_animacao() -> void:
	pass

func verificar_transicao_de_estado() -> void:
	if animacao_acabou == true:
		if direcao_de_movimento != 0:
			MDE.mudar_estado_ativo("Combate", "CombateAndando")
			return
		if direcao_de_movimento == 0:
			MDE.mudar_estado_ativo("Combate", "Combate")
			return
	
	if !Dono_do_estado.is_on_floor():
		MDE.mudar_estado_ativo("Especial", "NoAr")
