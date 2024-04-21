class_name DATABASE_GLOBAL
extends Node

var DTB_PERS:Dictionary
var DTB_ARM_L_DIS:Dictionary
var DTB_INIM:Dictionary
var DTB_ARM_ADE:Dictionary

func _ready():
	var ler_arquivo_0 = FileAccess.open("res://Matriz/Nucleo/Utilitarios/Json/Platform Vampire Survivor - Personagens.json",FileAccess.READ)
	DTB_PERS = JSON.parse_string(ler_arquivo_0.get_as_text())
	
	var ler_arquivo_1 = FileAccess.open("res://Matriz/Nucleo/Utilitarios/Json/Platform Vampire Survivor - Armas de Longa distancia.json", FileAccess.READ)
	DTB_ARM_L_DIS = JSON.parse_string(ler_arquivo_1.get_as_text())
	
	var ler_arquivo_2 = FileAccess.open("res://Matriz/Nucleo/Utilitarios/Json/Platform Vampire Survivor - Inimigos.json", FileAccess.READ)
	DTB_INIM = JSON.parse_string(ler_arquivo_2.get_as_text())
	
	var ler_arquivo_3 = FileAccess.open("res://Matriz/Nucleo/Utilitarios/Json/Platform Vampire Survivor - Armas de ataque em area.json", FileAccess.READ)
	DTB_ARM_ADE = JSON.parse_string(ler_arquivo_3.get_as_text())
