class_name EFEITOS_SONOROS_GLOBAIS
extends Node


func tocar_efeitos_sonoros_ecolocalisaveis(Dono:PhysicsBody2D, Posicao:Vector2, Son:AudioStream, distancia_maxima:float = 600) -> void:
	var Novo_son:AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	Novo_son.max_distance = distancia_maxima
	Novo_son.stream = Son
	Novo_son.global_position = Posicao
	Novo_son.autoplay = true
	Novo_son.finished.connect(func(): Novo_son.queue_free())
	Novo_son.volume_db = -10
	Dono.organizador_de_audios.add_child(Novo_son)
	
