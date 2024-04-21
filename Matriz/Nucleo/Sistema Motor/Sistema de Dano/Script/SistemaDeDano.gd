class_name SISTEMA_DE_DANO
extends Node

var Receptor:Node2D

func calculadora_de_dano_de_vida(Cura:bool, Tipo:String, Atributo:float, Dano_Base:float, Fator:float = 1) -> void:
	if Cura == false:
		if Receptor is PERSONAGEM_BASE:
			if Receptor.valores_do_jogador.resistencias.has(Tipo):
				var valor_calculado:float = ((Dano_Base + Atributo) / 2) / Fator
				Receptor.barra_de_vida.perder_vida(valor_calculado)
			elif Receptor.valores_do_jogador.fraquezas.has(Tipo):
				var valor_calculado:float = ((Dano_Base + Atributo) * 2) / Fator
				Receptor.barra_de_vida.perder_vida(valor_calculado)
			else:
				var valor_calculado:float = (Dano_Base + Atributo) / Fator
				Receptor.barra_de_vida.perder_vida(valor_calculado)
		elif Receptor is INIMIGO_BASE:
			if Receptor.valores_do_inimigo.resistencias.has(Tipo):
				var valor_calculado:float = ((Dano_Base + Atributo) / 2) / Fator
				Receptor.barra_de_vida.perder_vida(valor_calculado)
			elif Receptor.valores_do_inimigo.fraquezas.has(Tipo):
				var valor_calculado:float = ((Dano_Base + Atributo) * 2) / Fator
				Receptor.barra_de_vida.perder_vida(valor_calculado)
			else:
				var valor_calculado:float = (Dano_Base + Atributo) / Fator
				Receptor.barra_de_vida.perder_vida(valor_calculado)
		else:
			var valor_calculado:float = (Dano_Base + Atributo) / Fator
			Receptor.barra_de_vida.perder_vida(valor_calculado)
	else:
		if Receptor is PERSONAGEM_BASE: #|| receptor is INIMIGO_BASE
			if Receptor.valores_do_jogador.resistencias.has(Tipo):
				var valor_calculado:float = ((Dano_Base + Atributo) * 2) * Fator
				Receptor.barra_de_vida.ganhar_vida(valor_calculado)
			elif Receptor.valores_do_jogador.fraquezas.has(Tipo):
				var valor_calculado:float = ((Dano_Base + Atributo) / 2) * Fator
				Receptor.barra_de_vida.ganhar_vida(valor_calculado)
			else:
				var valor_calculado:float = (Dano_Base + Atributo) * Fator
				Receptor.barra_de_vida.ganhar_vida(valor_calculado)
		else:
			var valor_calculado:float = (Dano_Base + Atributo) * Fator
			Receptor.barra_de_vida.ganhar_vida(valor_calculado)

func calculadora_de_dano_de_estamina(Cura:bool, Atributo:float, Dano_Base:float, Fator:float) -> void:
	if Cura == false:
		if Receptor is PERSONAGEM_BASE:
			var valor_calculado:float = round(Dano_Base - (Atributo / Fator)) * Fator
			if valor_calculado <= 0:
				valor_calculado = 1
			Receptor.barra_de_estamina.perder_estamina(valor_calculado)
		else:
			push_error("Alvo: ", Receptor.name, " é um alvo invalido")
	else:
		if Receptor is PERSONAGEM_BASE:
			var valor_calculado:float = round(Dano_Base + (Atributo / Fator)) * Fator
			Receptor.barra_de_estamina.ganhar_estamina(valor_calculado)
		else:
			push_error("Alvo: ", Receptor.name, " é um alvo invalido")

func calculadora_de_dano_de_mana(Cura:bool, Dano_Base:float, Fator:float) -> void:
	if Cura == false:
		if Receptor is PERSONAGEM_BASE:
			var valor_calculado:float = Dano_Base * Fator
			Receptor.barra_de_mana.perder_mana(valor_calculado)
		else:
			push_error("Alvo: ", Receptor.name, " é um alvo invalido")
	else:
		if Receptor is PERSONAGEM_BASE:
			var valor_calculado:float = Dano_Base * Fator
			Receptor.barra_de_mana.ganhar_mana(valor_calculado)
		else:
			push_error("Alvo: ", Receptor.name, " é um alvo invalido")

