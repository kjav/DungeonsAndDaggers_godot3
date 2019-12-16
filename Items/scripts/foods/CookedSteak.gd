extends "FoodBase.gd"

func _init():
	iconFilePath = "res://assets/cooked_steak2.png"
	item_name = "Steak"
	texture = preload("res://assets/cooked_steak2.png")
	rarity = Enums.WEAPONRARITY.RARE

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
		.onUse()
		GameData.player.heal(3)
	else:
		GameData.hud.addEventMessage("Health is already full")
