extends "PotionBase.gd"

func _init():
	iconFilePath = "res://assets/black_simple_potion.webp"
	item_name = "Brief Defence"
	texture = preload("res://assets/black_simple_potion.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	.onUse()
	GameData.player.applyTemporaryDefence(15)
