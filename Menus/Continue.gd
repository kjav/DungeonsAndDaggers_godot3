extends TextureButton

# Only show if a save exists
func _ready():
	if GameData.has_save_game("OgresDomain"):
		show()
	else:
		hide()

func _pressed():
	GameData.load_game()
	get_tree().change_scene("Game.tscn")
