class_name ESTADO_MORRENDO
extends ESTADO_BASE

var limitador:bool = false

func ao_entrar_no_estado(_info:Dictionary = {}) -> void:
	super(_info)
	Dono_do_estado.morto = true
	pass

func finalizar_partida() -> void:
	await get_tree().create_timer(3).timeout
	var cena_teste = find_parent("Nova_Cena_Teste")
	var interface_pause = cena_teste.find_child("Interfaces").find_child("InterfaceDeMelhoriaDeAtributo")
	var interface_de_abertura_instancia = DATA.CON.Interface_De_Abertura.instantiate()
	interface_de_abertura_instancia.dinheiro_total = cena_teste.dinheiro_inicial + interface_pause.dinheiro_atual
	interface_de_abertura_instancia.presente_total = cena_teste.presente_inicial + interface_pause.presentes_adquiridos
	interface_de_abertura_instancia.altura_total = cena_teste.altura_inicial + interface_pause.pontos_de_altura_adquiridos
	get_tree().root.add_child(interface_de_abertura_instancia)
	cena_teste.queue_free()

func ao_sair_do_estado(_info:Dictionary = {}) -> void:
	pass

func no_process(_delta:float) -> void:
	pass

func no_physics_process(_delta:float) -> void:
	Dono_do_estado.velocity.y = Dono_do_estado.valores_do_jogador.gravidade_calculada
	Dono_do_estado.move_and_slide()
	if Dono_do_estado.is_on_floor():
		if limitador == false:
			Dono_do_estado.velocity = Vector2.ZERO
			Animacao.play(self.name)
			finalizar_partida()
			limitador = true

func verificar_transicao_de_estado() -> void:
	pass
