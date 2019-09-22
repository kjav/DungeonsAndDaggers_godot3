class HealthPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/red_potion2.png"
		item_name = "Health Potion"
		useSound = "HealthPotion_Drink"
		texture = preload("res://assets/red_potion2.png")
	
	func onUse():
		.onUse()
		GameData.player.increaseMaxHealth(1)

class DoubleDamagePotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/black_potion.png"
		item_name = "Double Damage Potion"
		texture = preload("res://assets/black_potion.png")
	
	func onUse():
		.onUse()
		GameData.player.applyDamageModifier(3)

class InvisibilityPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/clear_potion.png"
		item_name = "Invisibility Potion"
		texture = preload("res://assets/clear_potion.png")
	
	func onUse():
		.onUse()
		GameData.player.applyInvisibility(10)

class LevelUpPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/special_potion.png"
		item_name = "Level Up Potion"
		texture = preload("res://assets/special_potion.png")
	
	func onUse():
		.onUse()
		#open upgrade screen

class BreifHealthPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/red_simple_potion.png"
		item_name = "Breif Health Potion"
		texture = preload("res://assets/red_simple_potion.png")
	
	func onUse():
		.onUse()
		GameData.player.applyTemporaryHealth(15)
		
class BreifManaPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/blue_simple_potion.png"
		item_name = "Breif Mana Potion"
		texture = preload("res://assets/blue_simple_potion.png")
	
	func onUse():
		.onUse()
		GameData.player.applyTemporaryMana(15)

class BreifStrengthPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/black_simple_potion.png"
		item_name = "Breif Strength Potion"
		texture = preload("res://assets/black_simple_potion.png")
	
	func onUse():
		.onUse()
		GameData.player.applyTemporaryStrength(15)
		
class BreifDefencePotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/purple_simple_potion.png"
		item_name = "Breif Defence Potion"
		texture = preload("res://assets/purple_simple_potion.png")
	
	func onUse():
		.onUse()
		GameData.player.applyTemporaryDefence(15)