extends "PotionBase.gd"

func _init():
	._init()
	textureFilePath = "res://assets/red_simple_potion.webp"
	item_name = "Brief Health"
	item_description = "Temporarily increases your health and max health by 2 for 15 turns."
	texture = preload("res://assets/red_simple_potion.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	GameData.player.applyTemporaryHealth(turnCount())
	.onUse()

func turnCount():
	var turnCount = 15

	if GameData.player.extendBriefPotions:
		turnCount = 25
	
	return turnCount
