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

class DamagePotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/black_potion.png"
		item_name = "Damage Potion"
		texture = preload("res://assets/black_potion.png")
	
	func onUse():
		#Audio.playSoundEffect(useSound, true)
		.onUse()
		GameData.player.applyDamageModifier(2, 3)