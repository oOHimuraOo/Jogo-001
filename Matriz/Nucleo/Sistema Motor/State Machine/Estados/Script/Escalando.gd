class_name ESTADO_ESCALANDO
extends ESTADO_BASE

var novo_offset:float = 0.5
var velho_offset:float = 0

var novo_tamanho:Vector2 = Vector2(11,31.5)
var velho_tamanho:Vector2 = Vector2(25,31.5)

var direcao_de_movimento_y:float 
var liberador_de_ajuste_de_posicao:bool

var velocidade_de_movimento:float
var velocidade_vertical_alvo:float
var multiplicador_de_velocidade:float = 1
var redutor_de_velocidade:float = 2

var pode_consumir:bool
var estamina_consumida:float = 3
var fator_upgrade:float = 0.5
var cair_da_escalada:bool = false

func ao_entrar_no_estado(_info:Dictionary = {}) -> void:
	super(_info)
	if Dono_do_estado.barra_de_estamina.estamina_atual >= estamina_consumida:
		cair_da_escalada = false
		lidar_com_input_horizontal()
		consumir_estamina_cooldown_ativador()
		liberador_de_ajuste_de_posicao = true
		Dono_do_estado.velocity = Vector2.ZERO
		Dono_do_estado.area_de_colisao.shape.size = novo_tamanho
		Dono_do_estado.area_de_colisao.position.y = novo_offset
	else:
		cair_da_escalada = true


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
	Dono_do_estado.area_de_colisao.position.y = velho_offset
	Dono_do_estado.area_de_colisao.shape.size = velho_tamanho
	if get_child_count() > 0:
		get_child(0).queue_free()
	fator_upgrade = 0.5

func consumir_estamina() -> void:
	if pode_consumir == true:
		pode_consumir = false
		Dono_do_estado.sistema_de_dano.calculadora_de_dano_de_estamina(false, Dono_do_estado.valores_do_jogador.destreza, estamina_consumida, fator_upgrade)
		get_child(0).start()

func lidar_com_movimento_vertical(_delta:float) -> void:
	if sign(direcao_de_movimento_y) != sign(Dono_do_estado.velocity.y) && Dono_do_estado.velocity.y != 0:
		velocidade_vertical_alvo = 0
	else:
		velocidade_vertical_alvo = lerp(Dono_do_estado.velocity.y, direcao_de_movimento_y * velocidade_de_movimento, 1 - pow(Dono_do_estado.valores_do_jogador.fator_de_aceleracao, _delta))

func calcular_velocidade_final() -> void:
	if Dono_do_estado.barra_de_estamina.estamina_atual != 0:
		velocidade_de_movimento = Dono_do_estado.valores_do_jogador.velocidade_de_movimento * multiplicador_de_velocidade
	else:
		cair_da_escalada = true

func no_process(_delta:float) -> void:
	super(_delta)

func no_physics_process(_delta:float) -> void:
	lidar_com_animacao()
	calcular_velocidade_final()
	lidar_com_movimento_vertical(_delta)
	consumir_estamina()
	Dono_do_estado.velocity.y = velocidade_vertical_alvo 
	Dono_do_estado.move_and_slide()

func lidar_com_input_horizontal() -> void:
	super()
	direcao_de_movimento_y = Input.get_axis("W","S")
	
func lidar_com_direcao_da_animacao() -> void:
	if liberador_de_ajuste_de_posicao == true:
		if direcao_de_movimento == -1:
			Dono_do_estado.position.x -= 7
			liberador_de_ajuste_de_posicao = false
		if direcao_de_movimento == 1:
			Dono_do_estado.position.x += 7
			liberador_de_ajuste_de_posicao = false

func lidar_com_animacao() -> void:
	if direcao_de_movimento_y > 0:
		Animacao.play(self.name + "_descendo")
	elif direcao_de_movimento_y < 0:
		Animacao.play(self.name + "_subindo")
	elif direcao_de_movimento_y == 0:
		Animacao.play(self.name + "_parado")
		
func detector_de_colisao_com_parede(direcao:int) -> bool:
	var detector_de_parede_esquerda:Array = [Dono_do_estado.detecetor_de_parede_esquerda_1,Dono_do_estado.detecetor_de_parede_esquerda_2,Dono_do_estado.detecetor_de_parede_esquerda_3]
	var detector_de_parede_direita:Array = [Dono_do_estado.detecetor_de_parede_direita_1, Dono_do_estado.detecetor_de_parede_direita_2, Dono_do_estado.detecetor_de_parede_direita_3]
	var colidindo:bool
	if direcao > 0:
		for detector in detector_de_parede_direita:
			if detector.is_colliding():
				colidindo = true
			else:
				colidindo = false
		if colidindo == false and detector_de_parede_direita[0].is_colliding():
			colidindo = true
		elif colidindo == false and detector_de_parede_direita[1].is_colliding():
			colidindo = true
	elif direcao < 0:
		for detector in detector_de_parede_esquerda:
			if detector.is_colliding():
				colidindo = true
			else:
				colidindo = false
		if colidindo == false and detector_de_parede_esquerda[0].is_colliding():
			colidindo = true
		elif colidindo == false and detector_de_parede_esquerda[1].is_colliding():
			colidindo = true
	else:
		colidindo = false
	return colidindo

func verificar_transicao_de_estado() -> void:
	super()
	if direcao_de_movimento == 0:
		var info:Dictionary = {"Escalando": true}
		MDE.mudar_estado_ativo("Especial", "NoAr", info)
		return
	
	if Dono_do_estado.is_on_floor():
		var info:Dictionary = {"Escalando": true}
		MDE.mudar_estado_ativo("Especial", "NoAr",info)
		return
	
	if detector_de_colisao_com_parede(direcao_de_movimento) == false:
		var info:Dictionary = {"Escalando": true}
		MDE.mudar_estado_ativo("Especial", "NoAr", info)
		return
	
	if cair_da_escalada == true:
		var info:Dictionary = {"Escalando": true}
		MDE.mudar_estado_ativo("Especial", "NoAr", info)
		return
