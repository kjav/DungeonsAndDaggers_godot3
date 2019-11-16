extends "Item.gd"

func pickup():
	#todo, needs to check if inventory is full first
	GameData.addPotions([self])
	.pickup()

func onUse():
	if not .allowedToUse():
		return
	
	.onUse()
	GameData.potions.remove(GameData.potions.find(self))
	#Audio.playSoundEffect(useSound, true)