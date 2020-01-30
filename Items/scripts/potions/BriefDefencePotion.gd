extends "PotionBase.gd"

func _init():
	textureFilePath = "res://assets/black_simple_potion.png"
	item_name = "Brief Defence"
	texture = preload("res://assets/black_simple_potion.png")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyTemporaryDefence(15)
	.onUse()