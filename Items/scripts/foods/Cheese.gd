extends "FoodBase.gd"

func _init():
	textureFilePath = "res://assets/cheese_wedge.webp"
	item_name = "Cheese"
	texture = preload("res://assets/cheese_wedge.webp")
	rarity = Enums.WEAPONRARITY.UNCOMMON

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
		GameData.player.heal(amountToHeal())
		.onUse()
	else:
		GameData.hud.addEventMessage("Health is already full")

func amountToHeal():
	var heal = 2

	if GameData.player.increasedFoodHeal:
		heal = 2.5

	return heal