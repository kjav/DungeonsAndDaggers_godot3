class CookedSteak extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/cooked_steak2.png"
		item_name = "Cooked Steak"
		texture = preload("res://assets/cooked_steak2.png")
	
	func onUse():
		if not .allowedToUse():
			return
		
		if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
			.onUse()
			GameData.player.heal(3)

class Apple extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/apple.png"
		item_name = "Apple"
		texture = preload("res://assets/apple.png")
	
	func onUse():
		if not .allowedToUse():
			return
		
		if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
			.onUse()
			GameData.player.heal(1)

class Cheese extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/cheese_wedge.png"
		item_name = "Cheese"
		texture = preload("res://assets/cheese_wedge.png")
	
	func onUse():
		if not .allowedToUse():
			return
		
		if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
			.onUse()
			GameData.player.heal(2)