class_name AK48
extends ARMA_BASICA_DE_LONGA_DISTANCIA

var concatenacao = DATA.DAT.DTB_ARM_L_DIS
var info:Dictionary

func _ready() -> void:
	info = concatenacao[str(8)]
	modificar_valores_principais(info)
	super()

func modificar_valores_principais(novas_infos:Dictionary) -> void:
	index = int(novas_infos["Nivel"])
	nome = novas_infos["Nome"]
	self.name = nome
	balas_por_segundo = novas_infos["balas_por_segundo"]
	alcance_da_bala = novas_infos["Alcance_da_bala"]
	rotacao_de_descanso = novas_infos["Rotacao_de_Descanso"]
	dano = novas_infos["dano_base"]
	tipo = novas_infos["Tipo"]
	nivel = int(novas_infos["Nivel"])
	if novas_infos["variacao_de_mira_enquanto_parado"] != null:
		variacao_de_mira_enquanto_parado = float(novas_infos["variacao_de_mira_enquanto_parado"])/PI
	if novas_infos["variacao_de_mira_enquanto_em_movimento"] != null:
		variacao_de_mira_enquanto_em_movimento = float(novas_infos["variacao_de_mira_enquanto_em_movimento"])/PI
	if novas_infos["variacao_de_tiro"] != null:
		variacao_de_tiro = float(novas_infos["variacao_de_tiro"]) /PI
	

