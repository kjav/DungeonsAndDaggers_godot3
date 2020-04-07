extends TextureButton

func _pressed():
	get_node("../loading").show()
	Ad.show_privacy_form()
