extends VBoxContainer

var barra_vida:BARRA_DE_VIDA
var barra_mana:BARRA_DE_MANA
var barra_estamina:BARRA_DE_ESTAMINA
var barra_de_experiencia:BARRA_DE_EXPERIENCIA

func _input(_event):
	if barra_vida != null:
		if Input.is_action_just_pressed("Z"):
			if barra_vida.is_visible_in_tree():
				barra_vida.hide()
			else:
				barra_vida.show()
	if barra_mana != null:
		if Input.is_action_just_pressed("X"):
			if barra_mana.is_visible_in_tree():
				barra_mana.hide()
			else:
				barra_mana.show()
	if barra_estamina != null:
		if Input.is_action_just_pressed("C"):
			if barra_estamina.is_visible_in_tree():
				barra_estamina.hide()
			else:
				barra_estamina.show()
