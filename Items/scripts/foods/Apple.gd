extends "FoodBase.gd"

func _init():
	textureFilePath = "res://assets/apple.webp"
	item_name = "Apple"
	item_description = "Heals you up to 1 heart."
	texture = preload("res://assets/apple.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
		if GameData.chosen_map == "Tutorial" && GameData.current_level == 1:
			GameData.hud.get_node("TutorialTextPrompts").remove_child(GameData.hud.get_node("TutorialTextPrompts").get_child(3))
			GameData.player.addTutorialTextIfTutorial("Item use\ntakes up\na turn.", Vector2(7, 6.2))
		GameData.player.heal(1)
		.onUse()
	else:
		GameData.hud.addEventMessage("Health is already full")
