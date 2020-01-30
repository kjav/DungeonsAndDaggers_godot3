extends "PotionBase.gd"

func _init():
	textureFilePath = "res://assets/green_simple_potion.png"
	item_name = "Brief Strength"
	texture = preload("res://assets/green_simple_potion.png")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyTemporaryStrength(15)
	.onUse()