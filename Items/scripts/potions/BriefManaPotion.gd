extends "PotionBase.gd"

func _init():
	textureFilePath = "res://assets/blue_simple_potion.webp"
	item_name = "Brief Mana"
	texture = preload("res://assets/blue_simple_potion.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyTemporaryMana(15)
	.onUse()
