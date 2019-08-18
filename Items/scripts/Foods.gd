class CookedSteak extends "Item.gd":
	func _init():
		iconFilePath = "res://assets/cooked_steak2.png"
		description = "Mmmh suculent steak..."
		item_name = "Cooked Steak"
		useSound = "Food_Use"
		texture = preload("res://assets/cooked_steak2.png")
	
	func onUse():
		#Audio.playSoundEffect(useSound, true)
		.onUse()
		GameData.player.heal(2)
		GameData.foods.remove(GameData.foods.find(self))
