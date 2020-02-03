extends "FoodBase.gd"

func _init():
	iconFilePath = "res://assets/cheese_wedge.webp"
	item_name = "Cheese"
	texture = preload("res://assets/cheese_wedge.webp")
	rarity = Enums.WEAPONRARITY.UNCOMMON

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
		.onUse()
		GameData.player.heal(2)
	else:
		GameData.hud.addEventMessage("Health is already full")
