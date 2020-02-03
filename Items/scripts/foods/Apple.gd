extends "FoodBase.gd"

func _init():
	iconFilePath = "res://assets/apple.webp"
	item_name = "Apple"
	texture = preload("res://assets/apple.webp")

func onUse():
	if not .allowedToUse():
		.tryAgainOnTurnEnd()
		return
	
	if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
		if GameData.chosen_map == "Tutorial" && GameData.current_level == 1:
			GameData.hud.get_node("TutorialTextPrompts").remove_child(GameData.hud.get_node("TutorialTextPrompts").get_child(3))
			GameData.player.addTutorialTextIfTutorial("Item use\ntakes up\na turn", Vector2(7, 6.2))
		.onUse()
		GameData.player.heal(1)
	else:
		GameData.hud.addEventMessage("Health is already full")
