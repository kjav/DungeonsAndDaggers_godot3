extends TextureButton

func _pressed():
	GameData.next_level()
	get_parent().hide()