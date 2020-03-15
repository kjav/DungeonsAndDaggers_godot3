extends "PotionBase.gd"

func _init():
	textureFilePath = "res://assets/green_simple_potion.webp"
	item_name = "Brief Strength"
	texture = preload("res://assets/green_simple_potion.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyTemporaryStrength(turnCount())
	.onUse()

func turnCount():
	var turnCount = 15

	if GameData.player.extendBriefPotions:
		turnCount = 25
	
	return turnCount