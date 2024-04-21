@icon("res://Assets/Place Holder/Icones/PC Computer - Roblox - Spawn Location.png")
class_name PONTO_DE_SPAWN
extends Control

@onready var cooldown_do_spawn = $Cooldown_do_spawn
@onready var posicao_de_spawn_1 = $PosicaoDeSpawn1
@onready var posicao_de_spawn_2 = $PosicaoDeSpawn2
@onready var posicao_de_spawn_3 = $PosicaoDeSpawn3
@onready var posicao_de_spawn_4 = $PosicaoDeSpawn4
@onready var posicao_de_spawn_5 = $PosicaoDeSpawn5

var marcodor_posicao_original_1:Vector2
var marcodor_posicao_original_2:Vector2
var marcodor_posicao_original_3:Vector2
var marcodor_posicao_original_4:Vector2
var marcodor_posicao_original_5:Vector2

var contador_de_inimigos:float = 0
var limite_de_inimigos:float = 300
var posicao_de_spawn_atual:Vector2 = Vector2.ZERO

var array_de_index:Array = ["0","2","3","4","5","6","7","8","10"]
var pode_spawnar:bool = true

func _ready():
	randomize()
	marcodor_posicao_original_1 = posicao_de_spawn_1.position
	marcodor_posicao_original_2 = posicao_de_spawn_2.position
	marcodor_posicao_original_3 = posicao_de_spawn_3.position
	marcodor_posicao_original_4 = posicao_de_spawn_4.position
	marcodor_posicao_original_5 = posicao_de_spawn_5.position

func _process(_delta):
	self.global_position = find_parent("Nova_Cena_Teste").find_child("Camera").get_child(0).global_position

func atualizar_cooldown() -> void:
	if contador_de_inimigos <= limite_de_inimigos:
		cooldown_do_spawn.wait_time = (contador_de_inimigos + 1) / 100

func _on_timer_timeout():
	if pode_spawnar == true:
		if posicao_de_spawn_atual == Vector2.ZERO or posicao_de_spawn_atual == posicao_de_spawn_3.position:
			aleatorizar_marcador_de_spawn(posicao_de_spawn_1, 1)
			posicao_de_spawn_atual = posicao_de_spawn_1.position
		elif posicao_de_spawn_atual == posicao_de_spawn_1.position:
			aleatorizar_marcador_de_spawn(posicao_de_spawn_2, 2)
			posicao_de_spawn_atual = posicao_de_spawn_2.position
		elif posicao_de_spawn_atual == posicao_de_spawn_2.position:
			aleatorizar_marcador_de_spawn(posicao_de_spawn_3, 3)
			posicao_de_spawn_atual = posicao_de_spawn_3.position
		
		contador_de_inimigos = get_tree().get_nodes_in_group("Inimigo").size()
		
		atualizar_cooldown()
		instanciar_inimigo(array_de_index.pick_random())

func aleatorizar_marcador_de_spawn(marcador:Marker2D, valor:int) -> void:
	var randomizar:int = randi_range(0,100)
	var modificador_de_posicao = randf_range(50,100)
	
	if valor == 1:
		marcador.position = marcodor_posicao_original_1
	elif valor == 2:
		marcador.position = marcodor_posicao_original_2
	elif valor == 3:
		marcador.position = marcodor_posicao_original_3
	elif valor == 4:
		marcador.position = marcodor_posicao_original_4
	elif valor == 5:
		marcador.position = marcodor_posicao_original_5
	
	if randomizar >= 51:
		marcador.position.x += modificador_de_posicao
	else:
		marcador.position.x -= modificador_de_posicao

func instanciar_inimigo(index:String) -> void:
	var inimigo_instancia:INIMIGO_BASE = DATA.CON.Inimigo_Base.instantiate()
	inimigo_instancia.position = posicao_de_spawn_atual
	inimigo_instancia.personagem = get_tree().get_first_node_in_group("Jogador")
	inimigo_instancia.index = int(index)
	find_parent("Nova_Cena_Teste").find_child("Inimigos").find_child("Monstro").add_child(inimigo_instancia)
	if contador_de_inimigos < limite_de_inimigos:
		cooldown_do_spawn.start()
