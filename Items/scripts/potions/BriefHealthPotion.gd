extends "PotionBase.gd"

func _init():
	iconFilePath = "res://assets/red_simple_potion.webp"
	item_name = "Brief Health"
	texture = preload("res://assets/red_simple_potion.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	.onUse()
	GameData.player.applyTemporaryHealth(15)
