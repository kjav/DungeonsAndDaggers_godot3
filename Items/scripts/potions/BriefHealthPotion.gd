extends "PotionBase.gd"

func _init():
	iconFilePath = "res://assets/red_simple_potion.png"
	item_name = "Brief Health"
	texture = preload("res://assets/red_simple_potion.png")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyTemporaryHealth(15)
	.onUse()