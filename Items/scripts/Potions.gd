class HealthPotion extends "Item.gd":
	const texture = preload("res://assets/red_potion2.png")
	
	func _init():
		iconFilePath = "res://assets/red_potion2.png"
		description = "This drink heal your wounds!"
		item_name = "Health Potion"
		useSound = "HealthPotion_Drink"
	
	func onUse():
		#Audio.playSoundEffect(useSound, true)
		GameData.player.increaseMax(1)
		GameData.potions.remove(GameData.potions.find(self))
	
	func pickup():
		#todo, needs to check if inventory is full first
		GameData.addPotions([self])
		.pickup()
