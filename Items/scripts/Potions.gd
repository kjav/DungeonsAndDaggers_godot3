class HealthPotion extends "PotionBase.gd":
	func _init():
		iconFilePath = "res://assets/red_potion2.png"
		description = "This drink heal your wounds!"
		item_name = "Health Potion"
		useSound = "HealthPotion_Drink"
		texture = preload("res://assets/red_potion2.png")
	
	func onUse():
		#Audio.playSoundEffect(useSound, true)
		.onUse()
		GameData.player.increaseMax(1)
		GameData.potions.remove(GameData.potions.find(self))
