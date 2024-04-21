class_name ESTADO_PULANDO
extends ESTADO_BASE

var velocidade_de_pulo:float
var contador_de_pulos:int = 0
var Animacao_de_pulo_terminada:bool = false
var pulo_extra:bool = false


func ao_entrar_no_estado(_info:Dictionary = {}) -> void:
	super(_info)
	Dono_do_estado.pulos_atuais += 1
	Animacao_de_pulo_terminada = false
	Animacao.animation_finished.connect(quando_animacao_acabar)
	Animacao.play(self.name)
	if _info.has("Pulo_Extra"):
		pulo_extra = _info["Pulo_Extra"]
	instanciar_particula()

func instanciar_particula():
	var particula_instancia = DATA.CON.Particula_de_pulo.instantiate()
	particula_instancia.position = Dono_do_estado.position + Vector2(0,16)
	add_child(particula_instancia)

func ao_sair_do_estado(_info:Dictionary = {}) -> void:
	pulo_extra = false
	Animacao.animation_finished.disconnect(quando_animacao_acabar)

func quando_animacao_acabar() -> void:
	lidar_com_pulo()

func lidar_com_pulo() -> void:
	Animacao_de_pulo_terminada = true
	if pulo_extra == false:
		Dono_do_estado.velocity.y = Dono_do_estado.valores_do_jogador.velocidade_de_pulo
	else:
		Dono_do_estado.velocity.y = Dono_do_estado.valores_do_jogador.velocidade_do_pulo_extra

func no_physics_process(_delta:float) -> void:
	lidar_com_som_do_personagem()
	if Animacao_de_pulo_terminada == true:
		Dono_do_estado.move_and_slide()

func lidar_com_som_do_personagem() -> void:
	match Animacao.frame:
		0:
			DATA.SON.tocar_efeitos_sonoros_ecolocalisaveis(Dono_do_estado, Dono_do_estado.global_position, lista_de_efeitos_sonoros.pick_random())

func verificar_transicao_de_estado():
	super()
	if !Dono_do_estado.is_on_floor() && Animacao_de_pulo_terminada:
		MDE.mudar_estado_ativo("Especial", "NoAr")
		return
		
	


