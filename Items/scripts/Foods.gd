class CookedSteak extends "FoodBase.gd":
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

class Apple extends "FoodBase.gd":
	func _init():
		iconFilePath = "res://assets/apple.png"
		item_name = "Apple"
		texture = preload("res://assets/apple.png")
	
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

class Cheese extends "FoodBase.gd":
	func _init():
		iconFilePath = "res://assets/cheese_wedge.png"
		item_name = "Cheese"
		texture = preload("res://assets/cheese_wedge.png")
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