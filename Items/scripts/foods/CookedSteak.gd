extends "FoodBase.gd"

func _init():
	textureFilePath = "res://assets/cooked_steak2.webp"
	item_name = "Steak"
	item_description = "Heals you up to 3 hearts."
	texture = preload("res://assets/cooked_steak2.webp")
	rarity = Enums.WEAPONRARITY.RARE

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
	var heal = 3

	if GameData.player.increasedFoodHeal:
		heal = 3.5

	return heal
