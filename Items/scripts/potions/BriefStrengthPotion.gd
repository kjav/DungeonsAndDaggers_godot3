extends "PotionBase.gd"

func _init():
	iconFilePath = "res://assets/green_simple_potion.webp"
	item_name = "Brief Strength"
	texture = preload("res://assets/green_simple_potion.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	.onUse()
	GameData.player.applyTemporaryStrength(15)
