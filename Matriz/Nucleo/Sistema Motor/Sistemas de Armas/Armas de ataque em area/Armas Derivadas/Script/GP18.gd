class_name GP18
extends ARMA_BASICA_DE_ATAQUE_EM_AREA

var concatenacao = DATA.DAT.DTB_ARM_ADE
var info:Dictionary

func _ready() -> void:
	info = concatenacao[str(8)]
	modificar_valores_principais(info)
	super()

func modificar_valores_principais(novas_infos:Dictionary) -> void:
	index = int(novas_infos["Nivel"])
	nome = novas_infos["Nome"]
	self.name = nome
	balas_por_segundo = float(novas_infos["balas_por_segundo"]) 
	alcance_maximo = float(novas_infos["alcance_maximo"])
	rotacao_em_descanso = float(novas_infos["rotacao_em_descanso"])
	dano = float(novas_infos["dano_base"])
	tipo = novas_infos["Tipo"]
	raio_minimo = float(novas_infos["Raio_Minimo"])
	raio_maximo = float(novas_infos["Raio_Maximo"])
	descricao = novas_infos["descricao"]
	nivel = int(novas_infos["Nivel"])
	consumo_de_mana = float(novas_infos["consumo_de_mana"])
