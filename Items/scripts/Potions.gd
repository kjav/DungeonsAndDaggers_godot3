class HealthPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/red_potion2.png"
		item_name = "Health Potion"
		useSound = "HealthPotion_Drink"
		texture = preload("res://assets/red_potion2.png")
	
	func onUse():
		#Audio.playSoundEffect(useSound, true)
		.onUse()
		GameData.player.increaseMax(1)
		GameData.potions.remove(GameData.potions.find(self))

class DamageBoostPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/black_potion.png"
		item_name = "Damage Boost Potion"
		texture = preload("res://assets/black_potion.png")
	
	func onUse():
		#Audio.playSoundEffect(useSound, true)
		.onUse()
		GameData.player.applyDamageModifier(3)

class InvisibilityPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/clear_potion.png"
		item_name = "Invisibility Potion"
		texture = preload("res://assets/clear_potion.png")
	
	func onUse():
		#Audio.playSoundEffect(useSound, true)
		.onUse()
		GameData.player.applyInvisibility(10)

class LevelUpPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/special_potion.png"
		item_name = "Level Up Potion"
		texture = preload("res://assets/special_potion.png")
	
	func onUse():
		#Audio.playSoundEffect(useSound, true)
		.onUse()
		#open upgrade screen