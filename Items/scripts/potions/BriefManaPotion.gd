extends "PotionBase.gd"

func _init():
	iconFilePath = "res://assets/blue_simple_potion.webp"
	item_name = "Brief Mana"
	texture = preload("res://assets/blue_simple_potion.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	.onUse()
	GameData.player.applyTemporaryMana(15)
