class CookedSteak extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/cooked_steak2.png"
		item_name = "Cooked Steak"
		texture = preload("res://assets/cooked_steak2.png")
	
	func onUse():
		if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
			.onUse()
			GameData.player.heal(2.5)

class WholeChicken extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/chicken.png"
		item_name = "Whole Chicken"
		texture = preload("res://assets/chicken.png")
	
	func onUse():
		if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
			.onUse()
			GameData.player.heal(3.5)

class Apple extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/apple.png"
		item_name = "Apple"
		texture = preload("res://assets/apple.png")
	
	func onUse():
		if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
			.onUse()
			GameData.player.heal(1)

class Cabbage extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/cabbage.png"
		item_name = "Cabbage"
		texture = preload("res://assets/cabbage.png")
	
	func onUse():
		if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
			.onUse()
			GameData.player.heal(0.5)

class Cheese extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/cheese_wedge.png"
		item_name = "Cheese"
		texture = preload("res://assets/cheese_wedge.png")
	
	func onUse():
		if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
			.onUse()
			GameData.player.heal(2)

class Cake extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/cake.png"
		item_name = "Full Health Cake"
		texture = preload("res://assets/cake.png")
	
	func onUse():
		var amountHealed = GameData.player.stats.health.maximum - GameData.player.stats.health.value
		if amountHealed > 0 && GameData.player.alive():
			.onUse()
			GameData.player.heal(amountHealed)

class Bread extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/bread.png"
		item_name = "Bread"
		texture = preload("res://assets/bread.png")
	
	func onUse():
		if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
			.onUse()
			GameData.player.heal(1.5)

class BakedPie extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/baked_pie.png"
		item_name = "Baked Pie"
		texture = preload("res://assets/baked_pie.png")
	
	func onUse():
		if GameData.player.stats.health.maximum > GameData.player.stats.health.value && GameData.player.alive():
			.onUse()
			GameData.player.heal(3)