class CookedSteak extends "Item.gd":
	const texture = preload("res://assets/cooked_steak2.png")
	
	func _init():
		iconFilePath = "res://assets/cooked_steak2.png"
		description = "Mmmh suculent steak..."
		item_name = "Cooked Steak"
		useSound = "Food_Use"
	
	func onUse():
		#Audio.playSoundEffect(useSound, true)
		GameData.player.heal(2)
		GameData.foods.remove(GameData.foods.find(self))
		
	func pickup():
		#todo, needs to check if inventory is full first
		GameData.addFoods([self])
		.pickup()
