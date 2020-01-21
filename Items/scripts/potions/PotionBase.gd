extends "../Item.gd"

func pickup():
	#todo, needs to check if inventory is full first
	GameData.addPotions([self])
	.pickup()

func onUse():
	GameData.potions.remove(GameData.potions.find(self))
	.onUse()
	#Audio.playSoundEffect(useSound, true)