extends "PotionBase.gd"

func _init():
	textureFilePath = "res://assets/red_simple_potion.webp"
	item_name = "Brief Health"
	texture = preload("res://assets/red_simple_potion.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyTemporaryHealth(15)
	.onUse()
