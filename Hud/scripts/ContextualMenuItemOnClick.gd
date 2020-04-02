extends TextureButton
var item

func _pressed():
	GameData.player.pickUp(item)
	GameData.player.swiped(Enums.DIRECTION.NONE)
