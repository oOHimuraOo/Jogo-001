extends VBoxContainer

var barra_de_vida:BARRA_DE_VIDA

func _input(_event):
	if barra_de_vida != null:
		if Input.is_action_just_pressed("F"):
			if barra_de_vida.is_visible_in_tree():
				barra_de_vida.hide()
			else:
				barra_de_vida.show()
