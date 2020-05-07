extends "PotionBase.gd"

func _init():
	textureFilePath = "res://assets/black_simple_potion.webp"
	item_name = "Brief Defence"
	item_description = "Temporarily increases your defence for 15 turns. Defence makes any damage taken hit less on average."
	texture = preload("res://assets/black_simple_potion.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyTemporaryDefence(turnCount())
	.onUse()

func turnCount():
	var turnCount = 15

	if GameData.player.extendBriefPotions:
		turnCount = 25
	
	return turnCount
