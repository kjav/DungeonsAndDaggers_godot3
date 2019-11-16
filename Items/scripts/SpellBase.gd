extends "Item.gd"

func pickup():
	#todo, needs to check if inventory is full first
	GameData.addSpells([self])
	.pickup()

func onUse():
	if not .allowedToUse():
		return
	
	.onUse()
	GameData.spells.remove(GameData.spells.find(self))