extends "FoodBase.gd"

func _init():
	textureFilePath = "res://assets/cooked_steak2.png"
	item_name = "Steak"
	texture = preload("res://assets/cooked_steak2.png")
	rarity = Enums.WEAPONRARITY.RARE

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
		GameData.player.heal(3)
		.onUse()
	else:
		GameData.hud.addEventMessage("Health is already full")
