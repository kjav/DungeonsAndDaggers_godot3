extends TextureButton

func _pressed():
	GameData.player.pickUp()
	GameData.player.swiped(Enums.DIRECTION.NONE)

