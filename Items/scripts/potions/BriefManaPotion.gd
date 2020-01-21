extends "PotionBase.gd"

func _init():
	iconFilePath = "res://assets/blue_simple_potion.png"
	item_name = "Brief Mana"
	texture = preload("res://assets/blue_simple_potion.png")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyTemporaryMana(15)
	.onUse()